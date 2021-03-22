class CreateObjectives < ActiveRecord::Migration[6.0]
  def change
    create_table :objectives do |t|
      t.string :big_area, null: false
      t.text :text, null: false

      t.text :small_step1, null: false
      t.text :small_step2, null: false
      t.text :small_step3, null: false
      t.text :small_step4
      t.text :small_step5

      t.text :if_then1,    null: false
      t.text :if_then2,    null: false
      t.text :if_then3

      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
