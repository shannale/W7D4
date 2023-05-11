class SubsController < ApplicationController
    before_action :require_logged_in, only: [:new, :create, :update, :edit]
    before_action :user_is_mod?, only: [:edit, :update]

    def index
        @subs = Sub.all
        render :index
    end

    def new
        @sub = Sub.new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = current_user.id
        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def show
        @sub = Sub.find_by(id: params[:id])
        render :show
    end

    def edit
        @sub = Sub.find_by(id: params[:id])
        render :edit
    end

    def update
        @sub = Sub.new(sub_params)
        if @sub.update
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end
    end
    

    private

    def sub_params
        params.require(:sub).permit(:title, :description, :moderator_id)
    end

    def user_is_mod?
        self.moderator_id == current_user.id
    end
end
