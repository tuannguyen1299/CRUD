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
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'post was successfully created.' }
        format.js   {}
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @post = Post.new
    @search = Post.search params[:q]
    if admin_user
      @posts = @search.result.page(params[:page]).per(Settings.post_per_page)
    else
      @posts = @search.result.where(user_id: current_user.id).page(params[:page]).per(Settings.post_per_page)
    end
  end

  def edit; end

  def update
    if admin_user || set_user
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
    if set_user || admin_user
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, success: 'Post was successfully destroyed.' }
        format.json { head :no_content }
        format.js   { render layout: false }
      end
    else
      flash[:alert] = t '.alert'
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
