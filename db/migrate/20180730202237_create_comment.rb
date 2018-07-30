class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :pokemon_id
      t.timestamp :created_at
    end
  end
end
