# frozen_string_literal: true

class Post < ApplicationRecord
  has_attached_file :image
  validates_attachment :image,
                       content_type: { content_type: %r{\Aimage/.*\z} },
                       size: { less_than: 1.megabyte }
end
