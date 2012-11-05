class PagesController < ApplicationController
    def home
    end

    def parallax
        render :layout => false
    end
end
