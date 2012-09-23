class CategoriesController < ApplicationController
    def index
        @categories = Category.all
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(params[:category])
        if params[:cancel_button] || @category.save
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])
        if params[:cancel_button] || @category.update_attributes(params[:category])
            redirect_to root_path
        else
            render :edit
        end
    end

    def show
        @category = Category.find(params[:id])
    end

    def destroy
        @category = Category.find(params[:id])
        @category.destroy
    end
end
