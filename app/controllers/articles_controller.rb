class ArticlesController < ApplicationController
    before_filter :load_categorizable
    before_filter :find_article, :except => [ :index, :new, :create ]

    def index
        @articles = @categorizable.articles
    end

    def new
        #@article = @categorizable.articles.new
    end

    def create
#@article = @categorizable.articles.new(params[:article])
#        if params[:cancel_button] || @article.save
#            redirect_to admin_articles_path
#        else
#            render :new
#        end
    end

    def edit
    end

    def update
        if params[:cancel_button] || @article.update_attributes(params[:article])
            redirect_to :controller => 'admin/articles', :action => 'index'
        else
            render :edit
        end
    end

    def show
    end

    def destroy
        @article.each { |article| article.destroy}
        redirect_to admin_articles_path
    end

    private
        def find_article
            @article = @categorizable.articles.find(params[:id])
        end

        def load_categorizable
		    resource, id = request.path.split('/')[1, 2]
            @res = resource
            @this = id
#@categorizable = resource.singularize.classify.constantize.find(id)
		end
end
