class PagesController < ApplicationController
    def sprav_health
        @categories = Category.all
    end
end
