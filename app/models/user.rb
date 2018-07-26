class User < ActiveRecord::Base
    has_secure_password
    has_many :teams, dependent: :destroy
    has_many :pokemons, through: :teams, dependent: :destroy

    def correct_password?(password)
        
    end
end