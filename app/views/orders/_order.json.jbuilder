json.extract! order, :id, :meal, :user_id, :group_id, :restaurant, :joined, :invited, :status, :image, :created_at, :updated_at
json.url order_url(order, format: :json)
