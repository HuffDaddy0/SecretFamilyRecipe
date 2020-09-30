class User < ActiveRecord::Base
    belongs_to :family
    has_many :recipes
    has_many :ingredients
    validates :username, presence: true
    validates :username, uniqueness: true
    has_secure_password

end