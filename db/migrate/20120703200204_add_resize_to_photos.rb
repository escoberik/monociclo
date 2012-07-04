class AddResizeToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :resize, :boolean
  end
end
