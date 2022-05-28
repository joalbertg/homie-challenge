# frozen_string_literal: true

class Repository < ApplicationRecord
  belongs_to :user

  scope :with_user_id, ->(user_id) { where(sanitize_sql_array(['user_id = ?', user_id])) }
  scope :with_name, ->(name) { where('repositories.name LIKE ?', "%#{sanitize_sql_like(name)}%") }
  scope :with_full_name, lambda { |full_name|
    where('full_name LIKE :full_name', full_name: "%#{sanitize_sql_like(full_name)}%")
  }
end
