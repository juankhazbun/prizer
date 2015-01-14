class StaticPagesController < ApplicationController
  def home
    @subscriber = Subscriber.new
  end
end
