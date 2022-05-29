# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe('api/v1/users', type: :request, vcr: { record: :none }) do
  path '/api/v1/users/{id}' do
    parameter(name: 'id', in: :path, type: :string, description: 'id', example: 'octocat')

    get('show user') do
      tags('Users')
      description('Show a github profile')
      produces('application/json')

      response(200, 'successful') do
        let(:id) { 'octocat' }

        schema(
          type: :object,
          properties: {
            id: { type: :string, example: '484c5407-229f-45b7-8a60-a0fbb1901d74' },
            login: { type: :string, example: 'octocat' },
            github_id: { type: :integer, example: 583_231 },
            url: { type: :string, example: 'https://github.com/octocat' },
            name: { type: :string, example: 'The Octocat' },
            email: { type: :string, example: 'octocat@github.com' },
            avatar_url: { type: :string, example: 'https://avatars.githubusercontent.com/u/583231?v=4' },
            created_at: { type: :string, example: '2022-05-29T03:58:39.182Z' },
            updated_at: { type: :string, example: '2022-05-29T03:58:39.182Z' }
          },
          required: %w[id login github_id url name created_at updated_at]
        )

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['login']).to eq('octocat')
        end
      end

      response(404, 'user not found') do
        let(:id) { '404' }

        schema(
          type: :object,
          properties: { error: { type: :string, example: '#<Api::V1::Github::FindUserService:0x00007f0292eacf18>' } },
          required: %w[error]
        )

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to match(/Api::V1::Github::FindUserService/)
        end
      end
    end
  end
end
