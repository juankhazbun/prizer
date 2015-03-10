class SubscribersController < ApplicationController
  
  attr_accessor :email  

  # POST /subscribers
  def create
    @subscriber = Subscriber.new(subscriber_params)
    
    if @subscriber.save
      
      # Check if the subscriber win a prize
      prize = @subscriber.check_prize
      
      if (prize != "")
        flash[:success] = "Congratulations!!!. You won a #{prize}."        
      else
        flash[:danger] = 'You almost get it. Try again!'
      end
      redirect_to @subscriber
    else
      render "static_pages/home" 
    end
  end  

  private 
    # Never trust parameters from the scary internet, only allow the white list through.
    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end