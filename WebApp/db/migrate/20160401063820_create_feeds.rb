class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :source_name
      t.string :category_name
      t.string :url

      t.timestamps null: false
    end
  end
end
