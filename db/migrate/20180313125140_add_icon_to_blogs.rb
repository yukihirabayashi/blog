class AddIconToBlogs < ActiveRecord::Migration[5.1]
  def change
        remove_column :blogs, :icon, :string
  end
end
