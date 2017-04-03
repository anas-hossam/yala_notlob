json.extract! item, :id, :name, :user_id, :order_id, :amount, :price, :comment, :created_at, :updated_at
json.url item_url(item, format: :json)
