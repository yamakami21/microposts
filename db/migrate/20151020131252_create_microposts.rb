class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      # foreign_key: trueを指定することで、外部キー制約を設定して、
      # userテーブルに存在するidのuser_idに入るようにしている。
      
      # index: trueを指定することで、user_idにたいしてインデックスを作成し、
      # 指定したユーザの投稿を高速に検索することができる。
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
      # 複合インデックスと呼ばれ、投稿を指定ユーザーで絞り込んだ後、
      # 作成時間で検索や並び替えを行うという処理がより速く行えるようになる。
      t.index [:user_id, :created_at]
    end
  end
end