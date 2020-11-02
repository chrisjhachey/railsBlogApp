class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]        # ||= is a handy way to assign a variable if it isn't already assigned.
    end

    def logged_in?
        !!current_user      # !! turns a value into a true or a false
    end

    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        end
    end
end
