class AddColumnToPokemons < ActiveRecord::Migration
  def change
    add_column :pokemons, :speed, :integer
    add_column :pokemons, :team_id, :integer
  end
end
