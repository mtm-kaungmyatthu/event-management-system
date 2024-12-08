class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :name,     null: false
      t.text :description
      t.date :date,       null: false, default: Date.today
      t.time :time,       null: false, default: Date.today
      t.string :location
      t.boolean :status,  null: false, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
