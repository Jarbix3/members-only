class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.all.order("created_at DESC")
    @post = Post.new
    @users = User.all
  end

  def show
    @posts = Post.all.order("created_at DESC")
    @users = User.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "Se creo el post." }
      else
        @posts = Post.all

        format.html { render :index }
      end
    end
  end

  def edit
    @posts = Post.all
    @user = User.all
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to root_path, notice: "SE EDITO BIEN EL POST" }

      else
        format.html { render :edit }

      end
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "BORRASTE EL CUENTO"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
