class AddUniqReferenceToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :uniq_reference, :string, null: false, limit: 17
    add_index :tickets, :uniq_reference, unique: true
  end
end
