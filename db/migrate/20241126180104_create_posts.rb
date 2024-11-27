class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.timestamps
      t.string :title
      t.text :body
      t.references :user, null: false, foreign_key: true
    end
  end
end
