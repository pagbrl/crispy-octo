class ArticleMailerJob < ApplicationJob
  def perform(article_id, subscriber_id)
    @article = Article.find(article_id)
    @subscriber = Subscriber.find(subscriber_id)

    Rails.logger.info "Sending email to subscriber #{@subscriber.email} for article #{@article.title}"
    SubscriberMailer.with(subscriber: @subscriber, article: @article).article_email.deliver_now
  end
end
