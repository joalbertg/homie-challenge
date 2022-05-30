# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe('api/v1/repositories', type: :request, vcr: { record: :none }) do
  before do
    RedisSingleton.redis.flushall
  end

  path '/api/v1/repositories/search?name={name}&full_name={full_name}' do
    parameter(name: 'name', in: :path, type: :string, description: 'repository name', example: 'boysenberry-repo-1')
    parameter(
      name: 'full_name', in: :path, type: :string, description: 'repository name with username',
      example: 'octocat/boysenberry-repo-1'
    )

    get('search repository') do
      tags('Repositories')
      description('Search repositories by name and full_name')
      produces('application/json')

      response(200, 'successful') do
        let(:name) { 'boysenberry' }
        let(:full_name) { 'berry-repo' }

        schema('$ref': '#/components/schemas/repositories')

        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/repositories/search?name={name}&full_name={full_name}' do
    parameter(name: 'user_id', in: :path, type: :string, description: 'user_id', example: 'octocat')
    parameter(name: 'name', in: :path, type: :string, description: 'repository name', example: 'boysenberry-repo-1')
    parameter(
      name: 'full_name', in: :path, type: :string, description: 'repository name with username',
      example: 'octocat/boysenberry-repo-1'
    )

    get('search repository') do
      tags('Users')
      description('Search User repositories by name and full_name')
      produces('application/json')

      response(200, 'successful') do
        let(:user_id) { 'octocat' }
        let(:name) { 'boysenberry' }
        let(:full_name) { 'berry-repo' }

        schema('$ref': '#/components/schemas/repositories')

        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/repositories' do
    parameter(name: 'user_id', in: :path, type: :string, description: 'user_id', example: 'octocat')

    get('list repositories') do
      tags('Users')
      description('List User Repositories')
      produces('application/json')

      response(200, 'successful') do
        let(:user_id) { 'octocat' }

        run_test!
      end
    end
  end
end
