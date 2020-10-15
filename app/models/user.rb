class User < ActiveRecord::Base
    has_many :coins

    has_secure_password
end
