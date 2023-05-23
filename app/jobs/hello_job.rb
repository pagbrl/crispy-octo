class HelloJob < ApplicationJob
  queue_as :default

  def perform()
    Resque.logger.info "I'm running the hello job !"
  end
end
