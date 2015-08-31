class RemoveBookIdFromNotices < ActiveRecord::Migration
  def change
    remove_reference :notices, :book, index: true, foreign_key: true
  end
end
