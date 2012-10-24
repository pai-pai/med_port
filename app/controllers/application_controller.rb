class ApplicationController < ActionController::Base
    before_filter :set_session

    protect_from_forgery

    rescue_from CanCan::AccessDenied do |exception|
        if user_signed_in?
            redirect_to root_path
        else
            redirect_to new_user_session_path, :note => t('devise.messages.sign_in_to_see_this_page')
        end
    end

    private
        def set_session
            if devise_controller? && resource_name == :user && controller_name != 'registrations' && action_name == 'new'
                session["user_return_to"] = request.referer 
            end
        end

        def after_sign_in_path_for(users)
            session["user_return_to"] || root_path
        end

        def after_sign_out_path_for(users)
            request.referer
        end

        def check_authorized
            redirect_to new_user_session_path unless can? :admin, :all
        end
end
