class CreateSmallSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :small_steps do |t|
      t.text :small_step1, null: false
      t.text :small_step2, null: false
      t.text :small_step3, null: false
      t.text :small_step4
      t.text :small_step5
      t.references :user, foreign_key: true
      t.references :objective, foreign_key: true
      
      t.timestamps
    end
  end
end
