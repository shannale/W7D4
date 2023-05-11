class SessionsController < ApplicationController

    def new 
        @user = User.new
        render :new
    end 

    def create
        # debugger
        @user = User.find_by_credentials(params[:user][:username],params[:user][:password])
        # puts "hello"
        if @user 
            login!(@user)
            redirect_to user_url(@user)
        else 
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end 
    end 

    def destroy
        logout!
    end 


end
