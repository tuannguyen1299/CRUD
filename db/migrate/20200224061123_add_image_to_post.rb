# frozen_string_literal: true

class AddImageToPost < ActiveRecord::Migration[5.2]
  def change
    add_attachment :posts, :image
  end
end
