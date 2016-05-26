class CreatePreferenceSources < ActiveRecord::Migration
  def change
    create_table :preference_sources do |t|
      t.integer :user_id
      t.string :source_name

      t.timestamps null: false
    end
  end
end
