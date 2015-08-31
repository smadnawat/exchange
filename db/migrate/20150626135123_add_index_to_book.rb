class AddIndexToBook < ActiveRecord::Migration
  def change
  	#add_index "book", "subjects", name: "subjects", using: :btree
  	add_index "book", "title", name: "title", length: { "title" => 10 }, using: :btree
  	add_index "book", "author", name: "author", using: :btree
  end
end
