class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title, :null => false
      t.string :description, :null => true
      t.integer :type, :null => false
      t.string :location, :null => false
      t.string :thumbnail, :null => false

      t.timestamps
    end

    add_reference(:projects, :user, foreign_key: true)
  end
end
