class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.references :status, foreign_key: true
      t.references :user, foreign_key: true
      t.references :department, foreign_key: true
      t.string :subject, null: false
      t.text :description, null: false
      t.string :employee, null: false
      t.string :employee_email, null: false

      t.timestamps
    end
  end
end
