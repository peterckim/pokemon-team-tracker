class User < ActiveRecord::Base
    has_secure_password
    has_many :teams, dependent: :destroy
    has_many :pokemons, through: :teams, dependent: :destroy

    def slug
        self.name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        User.all.find{ |user| user.slug == slug }
    end
end