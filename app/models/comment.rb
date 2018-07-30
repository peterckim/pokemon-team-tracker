class Comment < ActiveRecord::Base
    belongs_to :pokemon
    belongs_to :user
end