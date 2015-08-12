class SubscribersController < FrontController
  def create
    @subscriber = Subscriber.new

    if @subscriber.update_attributes(subscriber_params)
      ApplicationMailer.new_subscriber_email(@subscriber).deliver
      render '_success', layout: false
    else
      render '_form', layout: false
    end
  end


  protected

  def subscriber_params
    params.require(:subscriber).permit(:first_name, :last_name, :company, :title, :phone_number, :email)
  end
end
