class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.string :ticket_id

      t.timestamps
    end
    add_foreign_key :comments, :tickets, column: :ticket_id, primary_key: "uniq_reference"
  end
end
