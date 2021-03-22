class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.date :date, null: false
      t.integer :data, null: false
      t.integer :unit_id, null: false
      t.text :inpression

      t.references :user, foreign_key: true
      t.references :objective, foreign_key: true 
      t.timestamps
    end
  end
end
