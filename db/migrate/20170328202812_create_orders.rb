class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :meal
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.string :restaurant
      t.integer :joined
      t.integer :invited
      t.string :status
      t.text :image

      t.timestamps
    end
  end
end
