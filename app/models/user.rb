class User < ActiveRecord::Base
    has_secure_password
    has_many :teams
    has_many :pokemons, through: :teams
    
end