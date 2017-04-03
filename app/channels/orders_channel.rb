class OrdersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "orders"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    # process data sent from the page
    # current_user.messages.create!(body: data['message'], chat_room_id: data['chat_room_id'])
    puts data['message']
    # if current_user.name.to_s == data['message'].to_s
    #   puts "yes"
    #
    #     # current_user.html { redirect_to order_path(1), notice: 'Order is created.' }
    # end
    current_user.notifications.create!(user_id: current_user.id, message: current_user.name<<" invited "<<data['message']<<" to order")

    # render "Invitation", notice: "#{data['message']} is invited to order"
  end
end
