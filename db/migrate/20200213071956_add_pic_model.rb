class AddPicModel < ActiveRecord::Migration[5.2]
  def change
    create_table :pics do |t|
      t.belongs_to :number
      t.string :description
      t.string :path

      t.timestamps
    end
  end
end
