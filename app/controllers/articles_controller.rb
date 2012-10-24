class ArticlesController < ApplicationController
    def index
        @articles = Article.healthcats.order(:name)
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
