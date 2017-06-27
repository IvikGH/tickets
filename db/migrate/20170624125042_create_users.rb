class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email,          null: false, default: ""
      t.string :first_name,     null: false
      t.string :last_name,      null: false
      t.boolean :administrator, null: false, default: false

      t.timestamps
    end
  end
end
