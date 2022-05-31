# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe('api/v1/repositories', type: :request, vcr: { record: :none }) do
  before do
    RedisSingleton.redis.flushall
  end

  path '/api/v1/repositories/search' do
    parameter(name: 'page', in: :query, type: :integer, description: 'page', example: 1)
    parameter(name: 'per_page', in: :query, type: :integer, description: 'per page', example: 2)
    parameter(name: 'name', in: :query, type: :string, description: 'repository name', example: 'boysenberry-repo-1')
    parameter(
      name: 'full_name', in: :query, type: :string, description: 'repository name with username',
      example: 'octocat/boysenberry-repo-1'
    )

    get('search repository') do
      tags('Repositories')
      description('Search repositories by name and full_name')
      produces('application/json')

      response(200, 'successful') do
        let(:name) { 'boysenberry' }
        let(:full_name) { 'berry-repo' }
        let(:page) { 1 }
        let(:per_page) { 2 }

        schema('$ref': '#/components/schemas/repositories')

        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/repositories/search' do
    parameter(name: 'user_id', in: :path, type: :string, description: 'user_id', example: 'octocat')

    parameter(name: 'page', in: :query, type: :integer, description: 'page', example: 1)
    parameter(name: 'per_page', in: :query, type: :integer, description: 'per page', example: 2)
    parameter(name: 'name', in: :query, type: :string, description: 'repository name', example: 'boysenberry-repo-1')
    parameter(
      name: 'full_name', in: :query, type: :string, description: 'repository name with username',
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
        let(:page) { 1 }
        let(:per_page) { 2 }

        schema('$ref': '#/components/schemas/repositories')

        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/repositories' do
    parameter(name: 'user_id', in: :path, type: :string, description: 'user_id', example: 'octocat')

    parameter(name: 'page', in: :query, type: :integer, description: 'page', example: 1)
    parameter(name: 'per_page', in: :query, type: :integer, description: 'per page', example: 2)

    get('list repositories') do
      tags('Users')
      description('List User Repositories')
      produces('application/json')

      response(200, 'successful') do
        let(:user_id) { 'octocat' }
        let(:page) { 1 }
        let(:per_page) { 2 }

        run_test!
      end
    end
  end
end
