class AddImageUrlToBook < ActiveRecord::Migration
  
  def self.up
    sql = ActiveRecord::Base.connection()
    sql.execute "SET autocommit=0"
    sql.begin_db_transaction
    sql.execute("CREATE TABLE book_new LIKE book")
    add_column :book_new, :image_url, :string
    sql.execute("INSERT INTO book_new SELECT *, NULL FROM book")
    rename_table :book, :book_old
    rename_table :book_new, :book
    sql.commit_db_transaction
    # don't forget to remove quarks_old someday
  end
 
  def self.down
    drop_table :book
    rename_table :book_old, :book
  end

end


