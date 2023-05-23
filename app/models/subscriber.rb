class Subscriber < ApplicationRecord
  validates :email, format: URI::MailTo::EMAIL_REGEXP,
                    uniqueness: { case_sensitive: false, message: "An error occurred while signing email up." }

  after_save :enqueue_welcome_send

  def enqueue_welcome_send
    return unless saved_change_to_attribute?(:email)

    Rails.logger.info "Enqueuing welcome email for user #{id}"

    WelcomeMailerJob.perform_later(id)
  end
end
