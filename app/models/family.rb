class Family < ActiveRecord::Base
    has_many :users
    has_many :recipes, through: :users
    has_secure_password
    validates :name, presence: true
    validates :name, uniqueness: true
end 