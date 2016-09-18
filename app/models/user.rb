class User < ActiveRecord::Base
	validates_format_of :username, :with => /\A[a-zA-Z0-9]*\z/

end