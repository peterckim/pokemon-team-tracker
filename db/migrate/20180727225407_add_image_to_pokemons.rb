class AddImageToPokemons < ActiveRecord::Migration
  def change
    add_column :pokemons, :image, :string
  end
end
