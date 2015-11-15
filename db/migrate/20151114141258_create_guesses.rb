class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.boolean  :correct
      t.boolean :first_round

      t.integer :card_id, null:false
      t.integer :history_id, null:false


      t.timestamps null:false

    end
  end
end
