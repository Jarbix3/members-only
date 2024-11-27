class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.all.order("created_at DESC")
    @post = Post.new
    @users = User.all
  end

  def show
    @popsts = Post.all.order("created_at DESC")
    @users = User.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "Post was successfully created." }
      else
        @posts = Post.all
        flash[:alert] = @post.errors.count
        format.html { render :index, alert: "Post was not created." }
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
        format.html { redirect_to root_path, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was succesfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
