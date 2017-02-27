class CreateIdeas < ActiveRecord::Migration[5.0]
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :description
      t.integer :likes, default: 0
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
