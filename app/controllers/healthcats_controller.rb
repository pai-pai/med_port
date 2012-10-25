class HealthcatsController < ApplicationController
    load_and_authorize_resource

    before_filter :find_healthcat, :except => [:index, :new, :create]

    def index
        @healthcats = Healthcat.all_parents
    end

    def new
        @healthcat = Healthcat.new
    end

    def create
        @healthcat = Healthcat.new(params[:healthcat])
        if params[:cancel_button] || @healthcat.save
            redirect_to healthcats_path
        else
            render :new
        end
    end

    def edit
    end

    def update
        if params[:cancel_button] || @healthcat.update_attributes(params[:healthcat])
            redirect_to healthcats_path
        else
            render :edit
        end
    end

    def show
        @children = @healthcat.subcats
        @categorizable = @healthcat
        @articles = @categorizable.articles
        @article = Article.new
    end

    def destroy
        @children = @healthcat.subcats
        if not @children.blank?
            @children.each do |child|
                Healthcat.find(child.id).destroy
            end
        end
        @healthcat.destroy
        redirect_to healthcats_path
    end

    private
        def find_healthcat
            @healthcat = Healthcat.find(params[:id])
        end
end
