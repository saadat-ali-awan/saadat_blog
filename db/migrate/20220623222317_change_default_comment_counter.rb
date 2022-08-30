class ChangeDefaultCommentCounter < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :comment_counter, :integer, :default => 0
  end
end
