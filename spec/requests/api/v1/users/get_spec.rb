# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('api/v1/users', type: :request, vcr: { record: :none }) do
  context 'when it is success' do
    describe('GET /api/v1/users/yknx4') do
      it 'returns a profile for yknx4 github user' do
        request(:get, '/api/v1/users/yknx4')

        expect(response).to have_http_status(:ok)
        expect(json_body).to include(
          'login' => 'yknx4',
          'github_id' => 1_848_186,
          'url' => 'https://github.com/yknx4',
          'name' => 'Ale Ornelas Figueroa',
          'email' => 'jade@ornelas.io',
          'avatar_url' => 'https://avatars.githubusercontent.com/u/1848186?v=4'
        )
      end
    end

    describe('GET /api/v1/users/HeyHomie') do
      it 'returns a profile for HeyHomie github user' do
        request(:get, '/api/v1/users/HeyHomie')

        expect(response).to have_http_status(:ok)
        expect(json_body).to include(
          'login' => 'HeyHomie',
          'github_id' => 42_941_835,
          'url' => 'https://github.com/HeyHomie',
          'name' => 'Homie',
          'email' => 'devops@homie.mx',
          'avatar_url' => 'https://avatars.githubusercontent.com/u/42941835?v=4'
        )
      end
    end
  end

  context 'when it fails' do
    describe('GET /api/v1/users/:id') do
      it 'returns a profile for yknx4 github user' do
        request(:get, '/api/v1/users/404')

        expect(response).to have_http_status(:not_found)
        expect(json_body['error']).to match(/Api::V1::Github::FindUserService/)
      end
    end
  end
end
