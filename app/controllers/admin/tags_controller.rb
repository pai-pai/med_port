class Admin::TagsController < ApplicationController
    before_filter :check_authorized

    load_and_authorize_resource

    layout "dashboard"

    def index
        @tags = Tag.order(:name).all
    end

    def new
        @tag = Article.new
    end

    def create
        @tag = Tag.new(params[:tag])
        if params[:cancel_button] || @tag.save
            redirect_to admin_tags_path
        else
            render :new
        end
    end

    def edit
        @tag = Tag.find(params[:id])
    end

    def update
        @tag = Tag.find(params[:id])
        if params[:cancel_button] || @tag.update_attributes(params[:tag])
            redirect_to admin_tags_path
        else
            render :edit
        end
    end

    def show
        @tag = Tag.find(params[:id])
    end

    def destroy
        Tag.find(params[:tags]).each { |tag| tag.destroy}
        redirect_to admin_tags_path
    end
end
