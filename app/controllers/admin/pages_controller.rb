class Admin::PagesController < ApplicationController
    authorize_resource :class => false

    layout "dashboard"

    def home
    end
end
