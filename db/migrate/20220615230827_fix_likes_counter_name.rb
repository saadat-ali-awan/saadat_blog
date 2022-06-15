class FixLikesCounterName < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :likes_counter, :like_counter
  end
end
