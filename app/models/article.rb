class Article < ApplicationRecord
  include Visible
  after_save :enqueue_mail_send

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  private

  def enqueue_mail_send
    Rails.logger.info "Changed : #{saved_change_to_attribute?(:status)}"

    return unless saved_change_to_attribute?(:status) && status == "public"

    Rails.logger.info "Planning enqueue job."
    Subscriber.all do |subscribers|
      subscribers.each do |subscriber|
        Rails.logger.info "Enqueuing #{subscriber.id}, article #{article_id}"
        ArticleMailerJob.perform_later(article_id, subscriber.id)
      end
    end
  end
end
