class SearchPostController < ApplicationController
  def index
    posts = Post.pluck :title
    render json: {posts: posts}
  end
end
