class SubscribersController < ApplicationController
  before_action :set_subscriber, only: [:show, :edit, :update, :destroy]
  
  attr_accessor :email  

  # GET /subscribers/new
  def new
    @subscriber = Subscriber.new
  end

  # POST /subscribers
  def create
    @subscriber = Subscriber.new(subscriber_params)
    
    if @subscriber.save
      
      # Check if the subscriber win a prize
      winners = @subscriber.check_prize(@subscriber.id)    
      
      puts "The subscriber win conditions " + winners.inspect
      
      redirect_to @subscriber, notice: 'Subscriber was successfully created.'
    else
      render "static_pages/home" 
    end
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end