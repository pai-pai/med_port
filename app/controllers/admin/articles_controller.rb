class Admin::ArticlesController < ApplicationController
    before_filter :check_authorized
    before_filter :find_categorizable, :only => [ :create, :update ]

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
        @article = @categorizable.articles.new(params[:article])
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

    private
        def find_categorizable
            @klass = params[:categorizable_type].capitalize.constantize
            params[:categorizable_id].blank? ? @categorizable = @klass.find(params[:article]["categorizable_id"]) : @categorizable = @klass.find(params[:categorizable_id])
		end
end
