class Admin::ArticlesController < ApplicationController
    before_filter :check_authorized

    load_and_authorize_resource

    layout "dashboard"

    def index
        if params[:cats].eql?("healthcats")
            @articles = Article.healthcats.order(:name)
        end
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(params[:article])
        if params[:cancel_button] || @article.save
            redirect_to admin_articles_path
        else
            render :new
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if params[:cancel_button] || @article.update_attributes(params[:article])
            redirect_to :controller => 'admin/articles', :action => 'index'
        else
            render :edit
        end
    end

    def show
        @article = Article.find(params[:id])
    end

    def destroy
        Article.find(params[:articles]).each { |article| article.destroy}
        redirect_to admin_articles_path
    end
end
