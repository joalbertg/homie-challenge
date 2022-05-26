# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Api::V1::Users::CreateService, type: :service) do
  describe '#call' do
    context 'when it is success' do
      describe 'a record is created' do
        subject(:user) { user_response.payload }

        let(:user_response) do
          described_class.call(build(:user).attributes.deep_symbolize_keys)
        end

        it 'has all the right attributes types' do
          expect(user_response).to have_attributes(
            success?: true,
            payload: user,
            error: nil
          )
        end

        it 'has all the right attributes' do
          expect(user).to have_attributes(
            login: 'octocat',
            github_id: 583_231,
            url: 'https://api.github.com/users/octocat',
            name: 'The Octocat',
            email: 'octocat@github.com',
            avatar_url: 'https://avatars.githubusercontent.com/u/583231?v=4'
          )
        end
      end
    end
  end
end
