class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|

      t.timestamps null: false
    end
  end
end
