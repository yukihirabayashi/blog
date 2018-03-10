class BlogsController < ApplicationController
    before_action :set_blog, only: [:show, :edit, :update, :destroy]
    before_action :login_check, only: [:new, :edit, :show ]
 
  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
      #変数 = 変数に代入したい値
      #.~で使用するものメソッド
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    #現在ログインしているuserのidをblogのuser_idカラムに挿入する。
    if @blog.save
       redirect_to blogs_path, notice: "ブログを作成しました！"
       ContactMailer.contact_mail(@blog).deliver
      
    else
      render 'new'
    end
  end
  
  def show
    
    # 追記する
    #    @blog = Blog.find(params[:id])
    
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)

  end
  
  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blogs_params)
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
    
  #      binding.pry
        
    @blog = Blog.new(blogs_params)
  end
 
  
 
  private
  
  def blogs_params
    params.require(:blog).permit(:name, :title, :content, )
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
  
  def login_check
    if current_user == nil
        redirect_to "/sessions/new"
    end
  end   
end
