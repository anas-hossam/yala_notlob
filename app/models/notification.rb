class Notification < ApplicationRecord
  belongs_to :user
  after_create_commit :add_notification
  def add_notification
    puts "00test after commit"
    NotificationWorker.perform_async(self)
    puts "test after commit"
  end
  def timestamp
  created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
