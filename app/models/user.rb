# frozen_string_literal: true

class User < ApplicationRecord
  has_many :repositories, dependent: :delete_all

  scope :with_id, ->(id) { where(sanitize_sql_array(['id = ?', id])) }
  scope :with_login, ->(login) { where(sanitize_sql_array(['login = ?', login])) }
  scope :with_github_id, ->(github_id) { where(sanitize_sql_array(['github_id = ?', github_id])) }
end
