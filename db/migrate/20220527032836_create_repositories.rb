# frozen_string_literal: true

class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table(:repositories, id: :uuid, comment: 'table of github repositories') do |t|
      t.integer(:repository_id, null: false)
      t.string(:name, null: false)
      t.string(:full_name, null: false)
      t.boolean(:private, null: false, default: false)
      t.string(:html_url, null: false)
      t.string(:description)
      t.string(:fork, null: false, default: 'f')
      t.string(:forks_url)
      t.string(:git_url)
      t.string(:ssh_url)
      t.string(:clone_url)
      t.string(:language)
      t.boolean(:allow_forking, null: false, default: true)
      t.integer(:forks_count)
      t.string(:visibility, null: false)
      t.string(:default_branch, null: false)
      t.uuid(:user_id, null: false, comment: 'user reference column')

      t.timestamps
    end

    add_index(:repositories, :repository_id, unique: true)
    add_index(:repositories, :user_id)

    add_foreign_key(:repositories, :users, column: :user_id, primary_key: :id)
  end
end
