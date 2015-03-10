require 'rails_helper'

describe SubscribersController do 

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Subscriber" do
        expect {          
          post :create, subscriber: attributes_for(:subscriber)
        }.to change(Subscriber, :count).by(1)
      end    
      
      it "redirects to the created subscriber" do
        post :create, subscriber: attributes_for(:subscriber)
        expect(response).to redirect_to(Subscriber.last)
      end
    end

    describe "with invalid params" do
      it "does not save the new subscriber" do
        expect {
          post :create, subscriber: attributes_for(:invalid_subscriber)
        }.to_not change(Subscriber, :count)
      end

      it "renders static_pages/home" do
        post :create, subscriber: attributes_for(:invalid_subscriber)
        expect(response).to render_template("static_pages/home") 
      end
    end
  end  
end