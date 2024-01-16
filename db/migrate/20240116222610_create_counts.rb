class CreateCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :counts do |t|
      t.string :text
      t.string :user
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
