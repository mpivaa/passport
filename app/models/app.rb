class App < ActiveRecord::Base
	has_many :user_apps
	ACTIVE = 1
	
	def uri
		url
	end

	def uri=(uri)
		url = uri
	end

	def all_active
		
	end
end
