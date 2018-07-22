class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :pokemons, :type, :element
  end
end
