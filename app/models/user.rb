# frozen_string_literal: true

class User < ApplicationRecord
  has_many :repositories, dependent: :delete_all

  scope :with_id, ->(id) { where('id = ?', id) }
  scope :with_login, ->(login) { where('login = ?', login) }
  scope :with_github_id, ->(github_id) { where('github_id = ?', github_id) }
end
