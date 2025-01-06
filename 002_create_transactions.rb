require 'active_record'

class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :description
      t.decimal :amount, null: false
      t.string :category, null: false
      t.datetime :date, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
