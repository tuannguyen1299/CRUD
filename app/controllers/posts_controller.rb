# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, except: [:index, :new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'success!'
      redirect_to posts_path
    else
      flash[:alert] = 'alert!'
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :describe, :content, :image)
  end
end
