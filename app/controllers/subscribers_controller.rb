class SubscribersController < ApplicationController
  
  attr_accessor :email  

  # POST /subscribers
  def create
    
    # Create the new subscriber
    @subscriber = Subscriber.new(subscriber_params)
    
    # Create the subscriber service to check for prizes
    checker = Services::SubscriberChecker.new
    
    # Save and check if the subscriber match a condition
    prize = checker.check_subscriber(@subscriber)
    
    # Check if the subscriber was succesfully saved
    if prize != "error"
      
      if (prize != false)
        flash[:success] = "Congratulations!!!. You won a #{prize}."        
      else
        flash[:danger] = 'You almost get it. Try again!'
      end
      redirect_to @subscriber.reload
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