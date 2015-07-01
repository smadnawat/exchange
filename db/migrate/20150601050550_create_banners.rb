class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :banner_name
      t.string :author_name
      t.string :link
      t.string :image
      t.integer :clicks, default: 0

      t.timestamps null: false
    end
  end
end
