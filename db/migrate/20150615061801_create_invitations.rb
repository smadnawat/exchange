class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.string :invitation_type
      t.integer :attendee
      t.string :status

      t.timestamps null: false
    end
  end
end
