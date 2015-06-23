class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.float :insights
      t.float :contributor
      t.float :social
      t.float :overallexperience
      t.string :comment
      t.integer :group_id
      t.integer :ratable_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
