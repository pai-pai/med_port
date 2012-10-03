class HealthcatsController < ApplicationController
    require "iconv"    

    load_and_authorize_resource

    def index
        @healthcats = Healthcat.may_be_a_parent
    end

    def new
        @healthcat = Healthcat.new
    end

    def create
        @healthcat = Healthcat.new(params[:healthcat])
        if params[:cancel_button] || @healthcat.save
            redirect_to healthcats_path
        else
            render :new
        end
    end

    def edit
        @healthcat = Healthcat.find(params[:id])
    end

    def update
        @healthcat = Healthcat.find(params[:id])
        if params[:cancel_button] || @healthcat.update_attributes(params[:healthcat])
            redirect_to healthcats_path
        else
            render :edit
        end
    end

    def show
        @healthcat = Healthcat.find(params[:id])
        @child_healthcats = @healthcat.child_healthcats
    end

    def destroy
        @healthcat = Healthcat.find(params[:id])
        @child_healthcats = @healthcat.child_healthcats
        if not @child_healthcats.blank?
            @child_healthcats.each do |child|
                Healthcat.find(child.id).destroy
            end
        end
        @healthcat.destroy
        redirect_to healthcats_path
    end
end
