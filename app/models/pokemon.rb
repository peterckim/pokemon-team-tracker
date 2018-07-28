class Pokemon < ActiveRecord::Base
    belongs_to :team
    belongs_to :users

    #slug
    def slug
        self.name.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        Pokemon.all.find{ |pokemon| pokemon.slug == slug }
    end

    def assign_image
        if self.slug == "nidoran"
            self.gender.downcase == "male" ? self.image = "#{self.slug}-m.png" : self.image = "#{self.slug}-f.png"
        else
            self.image = "#{self.slug}.png"
        end
    end
end