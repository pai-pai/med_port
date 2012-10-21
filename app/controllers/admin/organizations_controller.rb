class Admin::OrganizationsController < ApplicationController
    before_filter :check_authorized

    load_and_authorize_resource

    layout "dashboard"

    def index
        @organizations = Organization.order(:name).all
    end

    def new
        @organization = Organization.new
    end

    def create
        @organization = Organization.new(params[:organization])
        if params[:cancel_button] || @organization.save
            redirect_to admin_organizations_path
        else
            render :new
        end
    end

    def edit
        @organization = Organization.find(params[:id])
    end

    def update
        @organization = Organization.find(params[:id])
        if params[:cancel_button] || @organization.update_attributes(params[:organization])
            redirect_to :controller => 'admin/organizations', :action => 'index'
        else
            render :edit
        end
    end

    def show
        @organization = Organization.find(params[:id])
    end

    def destroy
        Organization.find(params[:organizations]).each { |organization| organization.destroy}
        redirect_to admin_organizations_path
    end
end
