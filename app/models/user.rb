class User < ApplicationRecord
	before_create :create_remember_token
	attr_accessor :remember_token

	has_many :posts	
	has_secure_password

	def new_token
		return SecureRandom.urlsafe_base64
	end

	private

		def create_remember_token
			token = new_token
			encrypted_token = Digest::SHA1.hexdigest(token.to_s)
			self.remember_token = encrypted_token
		end

end
