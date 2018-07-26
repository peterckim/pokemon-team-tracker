class Pokemon < ActiveRecord::Base
    belongs_to :team
    belongs_to :users
end