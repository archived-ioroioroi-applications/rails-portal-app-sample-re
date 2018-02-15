class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.timestamp :date, null: false
      t.string :category
      t.string :link, null: false
      t.string :title, null: false
      t.string :icon
      t.string :source_link, null: false
      t.string :source_title, null: false
      t.string :source_icon

      t.timestamps
    end
    add_index :articles,[:link], unique: true
  end
end
