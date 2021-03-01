class CreateObjectives < ActiveRecord::Migration[6.0]
  def change
    create_table :objectives do |t|
      t.string :big_area, null: false
      t.text :text, null: false
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
