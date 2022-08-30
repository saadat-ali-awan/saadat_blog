class UpdatePostCounterDatatype < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.change :posts_counter, :integer, using: 'posts_counter::integer'
    end
  end
end
