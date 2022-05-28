# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table(:users, id: :uuid, comment: 'table of github users') do |t|
      t.string(:login, null: false)
      t.integer(:github_id, limit: 8, null: false)
      t.string(:url, null: false)
      t.string(:name, null: false)
      t.string(:email)
      t.string(:avatar_url)

      t.timestamps
    end

    add_index(:users, :login, unique: true)
    add_index(:users, :github_id, unique: true)
    add_index(:users, :email, unique: true)
  end
end
