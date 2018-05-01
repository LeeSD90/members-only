class User < ApplicationRecord
	attr_accessor :remember_token

	before_create :create_remember_token
	has_secure_password

	private

		def create_remember_token
			token = SecureRandom.urlsafe_base64
			encrypted_token = Digest::SHA1.hexdigest(token.to_s)
			self.remember_token = encrypted_token
		end

end
