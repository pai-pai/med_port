class ArticlesController < ApplicationController
    load_and_authorize_resource

    before_filter :load_categorizable

    def index
        @articles = @categorizable.articles
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(params[:article])
        @article.categorizable = @categorizable
        @article.save!
        redirect_to healthcats_path
    end

    def edit
        @article = @categorizable.articles.find(params[:id])
    end

    def update
        @article = @categorizable.articles.find(params[:id])
        @article.update_attributes(params[:healthcat])
        redirect_to healthcats_path
    end

    def show
        @article = @categorizable.articles.find(params[:id])
    end

    def destroy
        @article = @categorizable.articles.find(params[:id])
        @article.destroy
        redirect_to root_path
    end

    private
        def find_article
            @article = @categorizable.articles.find(params[:id])
        end

        def load_categorizable
            if params[:resource]
                @categorizable = params[:resource].classify.constantize.find(params[:cat_id])
            end
		end
end
