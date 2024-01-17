class SearchesController < ApplicationController
  def index
    # display all saved searches for the current user using ip address tracking
    @searches = all_user_searches
    @counts = Count.where(user: request.remote_ip).order(count: :desc).limit(5)
  end

  def analytics
    @counts = Count.where(user: request.remote_ip).order(count: :desc).limit(5)
    respond_to do |format|
      format.json { render json: Search.group(:text).count }
      format.html { render partial: 'searches/analytics', status: :ok, locals: { counts: @counts } }
    end
  end

  # route for saving searches it saves the search term and user (via user ip address)
  # post 'searches/save'
  def save
    @search = Search.new(search_params)
    @search.user = request.remote_ip

    last_search = Search.where(user: request.remote_ip).order(created_at: :desc).first
    remove_last_saved_search(last_search, @search)
    @searches = all_user_searches

    respond_to do |format|
      if ignore_char_deletion?(last_search, @search)
        format.html { render partial: 'searches/save', status: :ok }
      elsif @search.save
        Count.find_or_create_by(text: @search.text, user: request.remote_ip).increment!(:count)
        format.html { render partial: 'searches/save', status: :ok }

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def ignore_char_deletion?(last_search, search)
    last_search && last_search.text.strip.start_with?(search.text.strip) && last_search.text != search.text
  end

  def all_user_searches
    Search.where(user: request.remote_ip).order(created_at: :asc)
  end

  def remove_last_saved_search(last_search, search)
    unless last_search && search.text.strip.start_with?(last_search.text.strip) && last_search.text != search.text
      return
    end

    last_search.destroy
    Count.where(text: last_search.text, user: request.remote_ip).first.decrement!(:count)
    return unless Count.where(text: last_search.text, user: request.remote_ip).first.count == 0

    Count.where(text: last_search.text, user: request.remote_ip).first.destroy
  end

  def search_params
    params.require(:search).permit(:text)
  end
end
