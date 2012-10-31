class ArticlesController < ApplicationController
    load_and_authorize_resource

    before_filter :find_categorizable, :except => [ :index, :health, :show ]

    def index
        @articles = Article.all
    end

    def health
        @groups = Article.all_healthcats.group_by { |article| article.name[0] }
    end

    def new
        @article = Article.new
    end

    def create
        @article = @categorizable.articles.new(params[:article])
        if params[:cancel_button] || @article.save
            respond_to do |format|
                format.html { redirect_to healthcat_subcat_path( @article.categorizable.parent, @article.categorizable ) }
            end
        else
            render :new
        end
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
        @article = Article.find(params[:id])
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

        def find_categorizable
            @klass = params[:categorizable_type].capitalize.constantize
            @categorizable = @klass.find(params[:categorizable_id])
		end
end
