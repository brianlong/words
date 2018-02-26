class CreateWords < ActiveRecord::Migration[5.1]
  def change
    create_table :words do |t|
      t.string :word
      t.timestamps
    end
    add_index :words, :word
  end
end
