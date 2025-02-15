class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.references :season, null: false, foreign_key: true
      t.text :title, null: false
      t.text :slug, null: false, index: {unique: true}
      t.datetime :start_at, null: false
      t.integer :max_registrations, null: false

      t.timestamps null: false
    end
  end
end
