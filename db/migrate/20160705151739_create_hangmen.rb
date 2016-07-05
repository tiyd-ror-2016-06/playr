class CreateHangmen < ActiveRecord::Migration
  def change
    create_table :hangmen do |t|
      t.string :word
      t.belongs_to :player, index: true #, foreign_key: true
      t.integer :lives_left, null: false, default: 6
      t.string :guesses, null: false, default: ""

      t.timestamps null: false
    end
  end
end
