# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'https://{productionHost}',
          variables: {
            productionHost: {
              default: 'homie-technical-challenge.herokuapp.com'
            }
          }
        },
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ],
      components: {
        schemas: {
          repositories: {
            type: 'object',
            properties: {
              repositories: {
                type: 'array',
                items: {
                  type: 'object',
                  properties: {
                    id: { type: 'string', example: '7ed34375-868f-4904-ac39-dfb9349ff841' },
                    user_id: { type: 'string', example: '484c5407-229f-45b7-8a60-a0fbb1901d74' },
                    repository_id: { type: 'integer', example: 132_935_648 },
                    name: { type: 'string', example: 'boysenberry-repo-1' },
                    full_name: { type: 'string', example: 'octocat/boysenberry-repo-1' },
                    html_url: { type: 'string', example: 'https://github.com/octocat/boysenberry-repo-1' },
                    description: { type: 'string', example: 'Testing' },
                    fork: { type: 'string', example: 't' },
                    forks_url: { type: 'string', example: 'https://api.github.com/repos/octocat/git-consortium/forks' },
                    git_url: { type: 'string', example: 'git://github.com/octocat/git-consortium.git' },
                    ssh_url: { type: 'string', example: 'git@github.com:octocat/git-consortium.git' },
                    clone_url: { type: 'string', example: 'https://github.com/octocat/git-consortium.git' },
                    language: { type: 'string', example: 'ruby' },
                    allow_forking: { type: 'boolean', example: true },
                    forks_count: { type: 'integer', example: 9 },
                    visibility: { type: 'string', example: 'public' },
                    default_branch: { type: 'string', example: 'master' }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
