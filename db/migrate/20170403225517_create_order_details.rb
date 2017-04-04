class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|
      t.references :user, foreign_key: true
      t.boolean :joined

      t.timestamps
    end
  end
end
