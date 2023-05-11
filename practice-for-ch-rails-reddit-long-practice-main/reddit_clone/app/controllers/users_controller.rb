class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        # debugger
        @user = User.new(user_params)
        if @user.save
            login!(@user)
            redirect_to new_session_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show 
        @user = User.find_by(id:params[:id])
        render :show
    end 


    def user_params
        params.require(:user).permit(:username, :password)
    end
end
