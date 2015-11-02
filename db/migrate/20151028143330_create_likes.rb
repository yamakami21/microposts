class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      # デプロイでエラーになる可能性あり
      t.references :user, index: true, foreign_key: true
      t.references :micropost, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end