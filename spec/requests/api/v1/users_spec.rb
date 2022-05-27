# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /index' do
    xit 'gets profile for yknx4' do
      get api_v1_users_path, params: { username: 'yknx4' }
      body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(body).to have_key('login')
      expect(body['login']).to eq('yknx4')
    end

    xit 'get profile for HeyHomie' do
      get api_v1_users_path, params: { username: 'HeyHomie' }
      body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(body).to have_key('login')
      expect(body['login']).to eq('HeyHomie')
    end
  end
end
