class FixCommentsCounterName < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :comments_counter, :comment_counter
  end
end
