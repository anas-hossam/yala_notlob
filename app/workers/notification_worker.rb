class NotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform(message)
    ActionCable.server.broadcast "orders_channel",message: render_message(message)
  end

  private

  def render_message(message)

     NotificationsController.renderer.render(partial: 'notifications/notification', locals: {notification: message})
  end
end
