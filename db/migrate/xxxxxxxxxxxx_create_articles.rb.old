class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :date
      t.string :article_link, null: false
      t.text :article_title, null: false
      t.string :article_source_link
      t.string :article_source
      t.timestamps
    end
    add_index :articles,[:article_link], unique: true # DB自体にユニーク制約を
  end
end
