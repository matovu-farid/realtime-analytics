require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let(:remote_ip) { '127.0.0.1' }
  let(:search_params) { { text: 'test search' } }

  before do
    request.remote_addr = remote_ip
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #analytics' do
    it 'returns a success response' do
      get :analytics, format: :json
      expect(response).to be_successful
    end
  end

  describe 'POST #save' do
    it 'creates a new Search' do
      expect {
        post :save, params: { search: search_params }
      }.to change(Search, :count).by(1)
    end

    it 'assigns the current user IP to the new Search' do
      post :save, params: { search: search_params }
      expect(Search.last.user).to eq(remote_ip)
    end
  end
end