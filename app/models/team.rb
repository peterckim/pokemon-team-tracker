class Team < ActiveRecord::Base
    has_many :pokemons, dependent: :destroy
    belongs_to :user

    def slug
        self.name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Team.all.find{ |team| team.slug == slug }
    end
end