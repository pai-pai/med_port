class ApplicationController < ActionController::Base
    protect_from_forgery

    rescue_from CanCan::AccessDenied do |exception|
        if user_signed_in?
            redirect_to root_path
        else
            redirect_to new_user_session_path, :note => t('devise.messages.sign_in_to_see_this_page')
        end
    end
end
