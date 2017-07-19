class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :interest, foreign_key: true
      t.references :user, foreign_key: true
      t.string :text
      t.string :attachment

      t.timestamps
    end
  end
end
