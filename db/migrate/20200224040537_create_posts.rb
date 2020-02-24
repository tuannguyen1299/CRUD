# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def up
    create_table :posts do |t|
      t.string :title
      t.string :describe
      t.string :content

      t.timestamps
    end
  end
end
