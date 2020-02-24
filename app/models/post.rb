# frozen_string_literal: true

class Post < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :describe, presence: true
  has_attached_file :image
  validates_attachment :image,
                       content_type: { content_type: %r{\Aimage/.*\z} },
                       size: { less_than: 1.megabyte }
end
