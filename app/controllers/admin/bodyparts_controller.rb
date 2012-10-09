class Admin::BodypartsController < ApplicationController
    before_filter :check_authorized

    load_and_authorize_resource

    layout "dashboard"
    
    def index
        @bodyparts = Bodypart.all
    end

    def new
        @bodypart = Bodypart.new
    end

    def create
        @bodypart = Bodypart.new(params[:bodypart])
        if params[:cancel_button] || @bodypart.save
            redirect_to admin_bodyparts_path
        else
            render :new
        end
    end

    def edit
        @bodypart = Bodypart.find(params[:id])
    end

    def update
        @bodypart = Bodypart.find(params[:id])
        if params[:cancel_button] || @bodypart.update_attributes(params[:bodypart])
            redirect_to :controller => 'admin/bodyparts', :action => 'index'
        else
            render :edit
        end
    end

    def show
        @bodypart = Bodypart.find(params[:id])
    end

    def destroy
        @bodypart = Bodypart.find(params[:id])
        @bodypart.destroy
        redirect_to admin_bodyparts_path
    end
end
