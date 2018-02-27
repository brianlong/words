class CreateLetterIndices < ActiveRecord::Migration[5.1]
  def change
    create_table :letter_indices do |t|
      t.bigint :word_id
      t.integer :position
      t.string :letter, limit: 1
      t.timestamps
    end
    add_index :letter_indices, :word_id
    add_index :letter_indices, [:position, :letter]
  end
end
