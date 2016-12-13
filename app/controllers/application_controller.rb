class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  # include ActionController::MimeResponds
  
  # Add a before_action to authenticate all requests.
  # Move this to subclassed controllers if you only
  # want to authenticate certain methods.
  
  #before_action :authenticate
  
  # protected
  
  # Authenticate the user with token basd authentication
  # def authenticate
	# authenticate_header || authenticate_params || render_unauthorized
  # end
  
  # def authenticate_header
	# authenticate_with_http_token do |token, options|
	  # @current_user = User.find_by(api_key: token)
	# end
  # end

  # def authenticate_params
	# @current_user = User.find_by(api_key: params[:token])
  # end
  
  # def render_unauthorized(realm = "Application")
	# self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
	# render json: 'Bad credentials', status: :unauthorized
  # end
  
  
end
