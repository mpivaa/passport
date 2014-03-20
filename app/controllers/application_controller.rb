class ApplicationController < ActionController::Base
	before_filter :authenticate_user!, :unless => ->(controller){ controller.request.format.json? }
  before_filter :restrict_api_access, :if => ->(controller){ controller.request.format.json? }
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  private

		def restrict_api_access
			access_key = AccessKey.find_by_key(params[:k])
			if access_key and access_key.is_valid
				access_key.renew
				if !user_signed_in?
					sign_in access_key.user
				end
			else
		 		head :unauthorized
		  end
		end
end
