class AddFolderIdToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :folder_id, :integer
  end
end
