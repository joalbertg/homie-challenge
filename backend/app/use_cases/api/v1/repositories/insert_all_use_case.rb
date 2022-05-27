# frozen_string_literal: true

module Api
  module V1
    module Repositories
      class InsertAllUseCase < ApplicationUseCase
        def initialize(params)
          super()

          @params = params
          @user = params[:user]
        end

        def call
          response(success: true, payload: insert_all_repositories)
        rescue => error
          response(error:)
        end

        private

        attr_reader :params, :user

        def insert_all_repositories
          github_repositories = search_repositories
          repositories = build_records(github_repositories)
          response = InsertAllService.call(user: user.login, repositories:)
          raise(response.error) unless response.success?

          response.payload
        end

        def search_repositories
          response = Github::SearchRepositoriesService.call(
            connection:,
            username: user.login,
            options: {
              per_page: 2,
              page: 1,
              sort: 'updated'
            }
          )
          raise(response.error) unless response.success?

          response.payload
        end

        def build_records(github_repositories)
          github_repositories.map do |repository|
            {
              **ids(repository),
              **details(repository),
              **urls(repository),
              **timestamps(repository),
              **extras(repository)
            }
          end
        end

        def ids(repository)
          {
            user_id: params[:user][:id],
            repository_id: repository['id']
          }
        end

        def details(repository)
          {
            name: repository['name'],
            full_name: repository['full_name'],
            description: repository['description'],
            language: repository['language']
          }
        end

        def urls(repository)
          {
            html_url: repository['html_url'],
            forks_url: repository['forks_url'],
            git_url: repository['git_url'],
            ssh_url: repository['ssh_url'],
            clone_url: repository['clone_url']
          }
        end

        def timestamps(repository)
          {
            created_at: repository['created_at'],
            updated_at: repository['updated_at']
          }
        end

        def extras(repository)
          {
            fork: repository['fork'],
            allow_forking: repository['allow_forking'],
            forks_count: repository['forks_count'],
            visibility: repository['visibility'],
            default_branch: repository['default_branch']
          }
        end
      end
    end
  end
end
