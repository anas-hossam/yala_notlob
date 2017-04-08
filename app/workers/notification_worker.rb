class NotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform(message)
    puts "yarab"
    ActionCable.server.broadcast "orders_channel",message: render_message(message)
  end

  private

  def render_message(message)
      puts "render message................................................................"
     # NotificationsController.renderer.render(partial: 'notifications/notification', locals: {notification: message})
      NotificationsController.render partial: 'notifications/notification', locals: {notification: message}

  end
end
