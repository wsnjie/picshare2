class AddUserTable < ActiveRecord::Migration[5.2]
  def change
    create_table :numbers do |t|
      t.string :number
      t.boolean :skip_sign_up, default: false

      t.timestamps
    end

    create_table :users do |t|
      t.integer :number_id
      t.string :name
      t.string :email

      t.timestamps
    end

    add_foreign_key :users, :numbers
  end
end
