class CreateSeasons < ActiveRecord::Migration[8.0]
  def change
    create_table :seasons do |t|
      t.text :name, null: false
      t.text :slug, null: false, index: {unique: true}

      t.timestamps null: false
    end
  end
end
