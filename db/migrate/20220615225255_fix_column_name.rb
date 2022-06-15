class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :posts_counter, :post_counter
  end
end
