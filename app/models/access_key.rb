class AccessKey < ActiveRecord::Base
	belongs_to :user
	
	def self.gen(user)
		key = SecureRandom.hex
		access_key = self.create(
			key: key,
			expire_at: DateTime.now + 30.minutes,
			user: user
		)
		key
	end

	def renew
		self.expire_at = DateTime.now + 30.minutes
		self.save
	end

	def is_valid
		self.expire_at >= DateTime.now
	end
end
