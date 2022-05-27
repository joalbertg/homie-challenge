# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Repositories', type: :request do
  describe 'GET /index' do
    xit 'gets repositories for yknx4' do
      get api_v1_user_repositories_path(user_id: 'yknx4')
      body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(body.size).to eq(100)
    end
  end
end
