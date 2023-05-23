class WelcomeMailerJob < ApplicationJob
  def perform(subscriber_id)
    @subscriber = Subscriber.find(subscriber_id)

    Rails.logger.info "Sending welcome email to subscriber #{@subscriber.email}"
    SubscriberMailer.with(subscriber: @subscriber).welcome_email.deliver_now
  end
end
