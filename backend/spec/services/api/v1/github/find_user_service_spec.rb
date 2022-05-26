# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Api::V1::Github::FindUserService, type: :service, vcr: { record: :none }) do
  describe '#call' do
    let(:connection) { Api::V1::HttpClient.call(token: 'bb06832b63a8639e04020967d048940feff31658').payload }

    context 'when it is success' do
      describe 'with valid username' do
        subject(:user) { user_response.payload }
        
        let(:user_response) { described_class.call(connection:, username: 'octocat') }

        it 'has correct types' do
          expect(user_response).to have_attributes(success?: true, payload: Hash, error: nil)
        end

        it 'has all the right attributes' do
          expect(user).to include(
            'login' => 'octocat',
            'id' => 583_231,
            'url' => 'https://api.github.com/users/octocat',
            'name' => 'The Octocat',
            'email' => 'octocat@github.com',
            'avatar_url' => 'https://avatars.githubusercontent.com/u/583231?v=4'
          )
        end
      end
    end

    context 'when it fails' do
      describe 'with invalid username' do
        it 'has correct types' do
          result = described_class.call(connection:, username: nil)
          expect(result).to have_attributes(success?: false, payload: {}, error: StandardError)
        end
      end
    end
  end
end
