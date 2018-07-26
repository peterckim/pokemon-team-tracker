class Pokemon < ActiveRecord::Base
    belongs_to :team
    belongs_to :users

    def slug
        self.name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Pokemon.all.find{ |pokemon| pokemon.slug == slug }
    end
end