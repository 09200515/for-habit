class CreateIfThens < ActiveRecord::Migration[6.0]
  def change
    create_table :if_thens do |t|
      t.text :if_then1, null: false
      t.text :if_then2, null: false
      t.text :if_then3
      t.references :user, foreign_key: true
      t.references :objective, foreign_key: true
      t.references :small_step, foreign_key: true

      t.timestamps
    end
  end
end
