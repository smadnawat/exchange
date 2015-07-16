class CreateScanningSubjects < ActiveRecord::Migration
  def change
    create_table :scanning_subjects do |t|

      t.timestamps null: false
    end
  end
end
