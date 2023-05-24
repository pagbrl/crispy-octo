class Admin::SubscribersController < ApplicationController
  def index
    @subscribers = Subscriber.all
  end

  def show
    @subscriber = Subscriber.find(params[:id])
  end

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      redirect_to admin_root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy

    redirect_to admin_root_path
  end

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
