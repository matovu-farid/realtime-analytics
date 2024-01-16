class SearchesController < ApplicationController
  def index
    # display all saved searches for the current user using ip address tracking
    @searches = all_user_searches
  end

  # route for saving searches it saves the search term and user (via user ip address)
  # post 'searches/save'
  def save
    @search = Search.new(search_params)
    @search.user = request.remote_ip

    last_search = Search.where(user: request.remote_ip).order(created_at: :desc).first
    @removed_last_saved = remove_last_saved_search(last_search, @search)
    @searches = all_user_searches

    respond_to do |format|
      if ignore_char_deletion?(last_search, @search)
        format.turbo_stream
        format.json { render json: @search, status: :ok }
      elsif @search.save
        format.turbo_stream
        format.json { render json: @search, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def ignore_char_deletion?(last_search, search)
    last_search && last_search.text.strip.start_with?(search.text.strip)
  end

  def all_user_searches
  Search.where(user: request.remote_ip).order(created_at: :asc)
  end

  def remove_last_saved_search(last_search, search)
    id = nil

    if last_search && search.text.strip.start_with?(last_search.text.strip)
      id = last_search.id
      last_search.destroy
    end
    id
  end

  def search_params
    params.require(:search).permit(:text)
  end
end
