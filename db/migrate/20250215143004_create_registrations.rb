class CreateRegistrations < ActiveRecord::Migration[8.0]
  def change
    create_table :registrations do |t|
      t.references :event, null: false, foreign_key: true
      t.text :slug, null: false, index: {unique: true}
      t.text :person_name, null: false
      t.text :registration_email, null: false
      t.text :branch, null: false

      t.timestamps null: false
    end
  end
end
