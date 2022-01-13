class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :body

      t.timestamps
    end

    add_reference(:contents, :project, foreign_key: true)
  end
end
