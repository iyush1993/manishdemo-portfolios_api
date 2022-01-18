class ChangeColumnsType < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :password, :password_digest
    change_column :contents, :body, :text
  end
end
