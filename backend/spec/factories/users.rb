# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    login { 'octocat' }
    github_id { 583231 }
    url { 'https://api.github.com/users/octocat' }
    name { 'The Octocat' }
    email { 'octocat@github.com' }
    avatar_url { 'https://avatars.githubusercontent.com/u/583231?v=4' }
  end
end
