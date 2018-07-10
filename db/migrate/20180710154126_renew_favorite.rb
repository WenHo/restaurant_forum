class RenewFavorite < ActiveRecord::Migration[5.1]
  def change
    add_column :favorites, :user_id, :integer
    add_column :favorites, :restaurant_id, :integer
  end
end
