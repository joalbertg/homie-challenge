# frozen_string_literal: true

FactoryBot.define do
  factory :repository do
    id { '7ed34375-868f-4904-ac39-dfb9349ff841' }
    repository_id { 132_935_648 }
    name { 'boysenberry-repo-1' }
    full_name { 'octocat/boysenberry-repo-1' }
    html_url { 'https://github.com/octocat/boysenberry-repo-1' }
    description { 'Testing' }
    fork { 't' }
    forks_url { 'https://api.github.com/repos/octocat/git-consortium/forks' }
    git_url { 'git://github.com/octocat/git-consortium.git' }
    ssh_url { 'git@github.com:octocat/git-consortium.git' }
    clone_url { 'https://github.com/octocat/git-consortium.git' }
    language { 'ruby' }
    allow_forking { true }
    forks_count { 9 }
    visibility { 'public' }
    default_branch { 'master' }
    association :user
  end
end
