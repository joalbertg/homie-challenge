class Repository < ApplicationRecord
  belongs_to :user

  scope :with_name, ->(name) { where("name LIKE ?", "%#{sanitize_sql_like(name)}%") }
  scope :with_full_name, ->(full_name) { where("full_name LIKE :full_name", full_name: "%#{sanitize_sql_like(full_name)}%") }
end
