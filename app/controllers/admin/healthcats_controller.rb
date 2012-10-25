class Admin::HealthcatsController < ApplicationController
    before_filter :check_authorized
    before_filter :find_healthcat, :only => [ :edit, :update, :show ]
    before_filter :bodyparts_list, :only => [ :edit, :update, :new, :create ]

    load_and_authorize_resource

    layout "dashboard"

    def index
        @healthcats = Healthcat.all_parents.page(params[:page]).per(50)
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
    end

    def update
        if params[:cancel_button] || @healthcat.update_attributes(params[:healthcat])
            redirect_to :controller => 'admin/healthcats', :action => 'index'
        else
            render :edit
        end
    end

    def show
        @children = @healthcat.subcats
    end

    def destroy
        Healthcat.find(params[:cats]).each do |cat|
            if not cat.subcats.blank?
                cat.subcats.each do |child|
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
                if not cat.subcats.blank?
                    cat.subcats.each do |child|
                        Healthcat.find(child.id).destroy
                    end
                end
                cat.destroy
            end
            redirect_to admin_healthcats_path
        elsif params[:move_button]
            Healthcat.find(params[:cats]).each do |cat|
                if not cat.subcats.blank?
                    cat.subcats.each do |child|
                        child.update_attributes(:parent_id => params[:parent_cat])
                    end
                end
                cat.update_attributes(:parent_id => params[:parent_cat])
            end
            redirect_to admin_healthcats_path
        end        
    end

    private
        def find_healthcat
            @healthcat = Healthcat.find(params[:id])
        end

        def bodyparts_list
            @bodyparts = Bodypart.order(:name).all
        end
end
