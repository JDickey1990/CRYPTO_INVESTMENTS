class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.string :name
      t.string :symbol
      t.integer :quantity
      t.integer :amount_invested
      t.integer :average_coin_price
      t.string :user_id
      t.timestamps null: false
    end
  end
end

