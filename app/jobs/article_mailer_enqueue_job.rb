class ArticleMailerEnqueueJob < ApplicationJob
  def perform(article_id)
    Rails.logger.info "Article #{article_id} published, enqueueing jobs."

    Subscriber.find_in_batches(batch_size: 500) do |subscribers|
      subscribers.each do |subscriber|
        Rails.logger.info "Enqueuing #{subscriber.id}, article #{article_id}"
        ArticleMailerJob.perform_later(article_id, subscriber.id)
      end
    end

    Resque.logger.info "Jobs enqueued"
  end
end
