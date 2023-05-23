class SubscriberMailer < ApplicationMailer
  def welcome_email
    @url = "127.0.0.1:3000"
    @subscriber = params[:subscriber]
    Rails.logger.info "#{@subscriber.id} - #{@subscriber.email}"
    mail(to: @subscriber.email, subject: "Welcome to the blog !")
  end

  def article_email
    @url = "127.0.0.1:3000"
    @subscriber = params[:subscriber]
    @article = params[:article]

    Rails.logger.info "#{@article.id} #{@subscriber.id} - #{@subscriber.email}"
    mail(to: @subscriber.email, subject: "#{@article.title} - AwesomeBlog")
  end
end
