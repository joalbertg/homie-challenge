# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Api::V1::Users::FindService, type: :service) do
  describe '#call' do
    context 'when it is success' do
      describe 'with id nil' do
        it 'has correct types' do
          result = described_class.call(github_id: nil)
          expect(result).to have_attributes(success?: true, payload: nil, error: nil)
        end
      end

      describe 'with valid id' do
        before { create(:user) }

        it 'has all the right attributes types' do
          result = described_class.call(github_id: 583_231)

          expect(result).to have_attributes(success?: true, payload: User, error: nil)
        end

        it 'has all the right attributes' do
          result = described_class.call(github_id: 583_231)
          user = result.payload

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
