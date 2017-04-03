class NotificationBroadcastJob < ApplicationJob
  queue_as :default
  def perform(message)
    ActionCable.server.broadcast "orders_channel",message: render_message(message)
  end

  private

  def render_message(message)
    puts message<<"   in job"
     NotificationsController.renderer.render(partial: 'notifications/notification', locals: {message: message})
  end
end
