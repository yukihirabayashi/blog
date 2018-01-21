class BlogsController < ApplicationController
    before_action :set_blog, only: [:show, :edit, :update, :destroy]
   before_action :login_check, only: [:new, :edit, :show ]
 
  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
       redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      render 'new'
    end
  end
  
  def show
    # 追記する
    @blog = Blog.find(params[:id])
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end
 
  def login_check
  #  binding.pry
    
    if current_user == nil
        redirect_to "/sessions/new"
    end
  end   
 
  private
  
  def blog_params
    params.require(:blog).permit(:name, :email, :title, :content, )
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
end