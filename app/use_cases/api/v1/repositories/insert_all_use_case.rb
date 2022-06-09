# frozen_string_literal: true

module Api
  module V1
    module Repositories
      class InsertAllUseCase < ApplicationUseCase
        def initialize(params)
          super()

          @params = params
          @user = params[:user]
          @records = []
          @page = 1
        end

        def call
          response(success: true, payload: insert_all_repositories)
        rescue => error
          response(error:)
        end

        private

        attr_reader :params, :user, :records, :page

        def insert_all_repositories
          loop do
            github_repositories = search_repositories
            break if github_repositories.empty?

            repositories = build_records(github_repositories)
            response = InsertAllService.call(user: user.login, repositories:)
            raise(response.error) unless response.success?

            @page += 1
            records << response.payload
          end
          records
        end

        def search_repositories
          response = Github::SearchRepositoriesService.call(
            connection:,
            username: user.login,
            options: {
              per_page: 100,
              page:,
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
            }.symbolize_keys
          end
        end

        def ids(repository)
          {
            user_id: params[:user][:id],
            repository_id: repository['id']
          }
        end

        def details(repository)
          repository.slice(*%w[name full_name description language])
        end

        def urls(repository)
          repository.slice(*%w[html_url forks_url git_url ssh_url clone_url])
        end

        def timestamps(repository)
          repository.slice(*%w[created_at updated_at])
        end

        def extras(repository)
          repository.slice(*%w[fork allow_forking forks_count visibility default_branch])
        end
      end
    end
  end
end
