class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.order(id: :asc)
  end

  def show

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post, notice: "投稿しました"
    else
      flash.now[:alert] = "投稿に失敗しました"
      #flash[:alert] = "投稿に失敗しました"    #フラッシュがレンダー後も残ってしまう
      render :new
      #redirect_to action: :new   #入力した文字が消えてしまう
    end
    #redirectとflashをまとめて書く
    #redirect_to post, notice: "投稿しました"

    #flash[:notice] = "投稿しました"
    #redirect_to post
  end

  def edit
    
  end

  def update
    if @post.update(post_params)  #@を追加
      redirect_to @post, notice: "更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @post.destroy!              #@を追加
    redirect_to root_path, alert: "削除しました"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
