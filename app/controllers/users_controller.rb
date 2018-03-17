class UsersController < ApplicationController
    def new
        @user = User.new
        
    end
    
    def create
        @user = User.new(user_params)

        if @user.save
            redirect_to user_path(@user.id)
        else
            render 'new'
        end
    end
    
    def show
        @user = User.find(params[:id])  
        
       
        # @favorite = current_user.favorites.find_by(blog_id: @blog.id)
        
        # ログインユーザーが登録したお気に入りをすべて取得する
         @favorites_blogs = @user.favorite_blogs
         
    end
    
    private
    
    def user_params
        params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :icon)
    end

end