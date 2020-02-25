# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, except: [:index, :new, :create]
  before_action :set_user, only: [:edit, :destroy]
  before_action :admin_user, only: [:index, :edit, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      flash[:success] = t '.success'
      redirect_to posts_path
    else
      flash[:alert] = t '.alert'
      render :new
    end
  end

  def index
    if admin_user
      @posts = Post.all
    else
      @posts = Post.where(user_id: current_user.id)
    end
  end

  def edit; end

  def update
    if admin_user
      post_params.delete :active if set_user.present?
      @post.update(post_params)
      flash[:success] = t '.success'
      redirect_to posts_path
    else
      flash[:alert] = t '.alert'
      redirect_to posts_path
    end
  end

  def destroy
    if set_user or admin_user
      @post.destroy
      flash[:success] = t '.success'
      redirect_to posts_path
    else
      flash[:alert] = t '.alert'
      redirect_to posts_path
    end
  end

  private

  def set_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :describe, :content, :image, :active)
  end

  def set_user
    current_user.id == @post.user_id
  end

  def admin_user
    current_user.admin?
  end
end
