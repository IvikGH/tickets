class CreateTicketChanges < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_changes do |t|
      t.string :ticket_id
      t.string :attribute_class, null: false
      t.string :prev_value, null: false
      t.string :current_value, null: false

      t.timestamps
    end

    add_foreign_key :ticket_changes, :tickets,
                    column: :ticket_id, primary_key: "uniq_reference"

    add_index :ticket_changes, :ticket_id
  end
end
