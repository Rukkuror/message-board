class AddScreenShotToPost < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :website_url, :string
  end
end
