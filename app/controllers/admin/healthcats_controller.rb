class Admin::HealthcatsController < ApplicationController
    before_filter :check_authorized

    load_and_authorize_resource

    layout "dashboard"

    def index
        @healthcats = Healthcat.may_be_a_parent.page(params[:page]).per(50)
    end

    def new
        @healthcat = Healthcat.new
    end

    def create
        @healthcat = Healthcat.new(params[:healthcat])
        if params[:cancel_button] || @healthcat.save
            redirect_to admin_healthcats_path
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
            redirect_to :controller => 'admin/healthcats', :action => 'index'
        else
            render :edit
        end
    end

    def show
        @healthcat = Healthcat.find(params[:id])
        @child_healthcats = @healthcat.child_healthcats
    end

    def show_child
        @healthcat = Healthcat.find(params[:id])
    end

    def destroy
        Healthcat.find(params[:cats]).each do |cat|
            if not cat.child_healthcats.blank?
                cat.child_healthcats.each do |child|
                    Healthcat.find(child.id).destroy
                end
            end
            cat.destroy
        end
        redirect_to admin_healthcats_path
    end

    def move
        if params[:delete_button]
            Healthcat.find(params[:cats]).each do |cat|
                if not cat.child_healthcats.blank?
                    cat.child_healthcats.each do |child|
                        Healthcat.find(child.id).destroy
                    end
                end
                cat.destroy
            end
            redirect_to admin_healthcats_path
        elsif params[:move_button]
            Healthcat.find(params[:cats]).each do |cat|
                if not cat.child_healthcats.blank?
                    cat.child_healthcats.each do |child|
                        child.update_column(:parent_healthcat_id, params[:parent_cat])
                        child.save
                    end
                end
                cat.update_column(:parent_healthcat_id, params[:parent_cat])
                cat.save
            end
            redirect_to admin_healthcats_path
        end        
    end
end
