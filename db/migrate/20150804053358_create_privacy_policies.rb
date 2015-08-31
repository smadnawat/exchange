class CreatePrivacyPolicies < ActiveRecord::Migration
  def change
    create_table :privacy_policies do |t|
      t.text :description

      t.timestamps null: false
    end
  end
end
