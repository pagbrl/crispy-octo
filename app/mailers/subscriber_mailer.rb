class SubscriberMailer < ApplicationMailer
  def welcome_email
    @url = "#{ENV.fetch('EMAIL_FROM')}"
    @subscriber = params[:subscriber]
    Rails.logger.info "#{@subscriber.id} - #{@subscriber.email}"
    mail(to: @subscriber.email, subject: "Welcome to the blog !")
  end

  def article_email
    @url = "#{ENV.fetch('EMAIL_FROM')}"
    @subscriber = params[:subscriber]
    @article = params[:article]

    Rails.logger.info "#{@article.id} #{@subscriber.id} - #{@subscriber.email}"
    mail(to: @subscriber.email, subject: "#{@article.title} - AwesomeBlog")
  end
end
