class CreateSetEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :set_entries do |t|
      t.integer :set_number
      t.integer :reps
      t.integer :weight
      t.references :exercise_entry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
