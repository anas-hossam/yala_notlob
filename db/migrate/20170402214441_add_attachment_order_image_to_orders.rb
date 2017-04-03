class AddAttachmentOrderImageToOrders < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.attachment :order_image
    end
  end

  def self.down
    remove_attachment :orders, :order_image
  end
end
