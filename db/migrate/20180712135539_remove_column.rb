class RemoveColumn < ActiveRecord::Migration[5.1]
  def change
  	remove_column :restaurants , :favorites_count 
  	add_column :restaurants, :favorites_count, :integer, default: 0
  end
end
