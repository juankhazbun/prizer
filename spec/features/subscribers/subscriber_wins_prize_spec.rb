require 'rails_helper'

feature 'Admin creates a new prize' do
  
  let!(:condition) { create(:condition) }  
  let!(:subscriber) { create(:subscriber, id: 24) } 
  let(:new_subscriber) { build(:subscriber) }
  
  scenario 'An email can only be entered one a day' do  
    visit root_path
    fill_in 'Email', with: new_subscriber.email
    click_button 'Subscribe!' 
    # Try to subscribe with the same email
    visit root_path 
    fill_in 'Email', with: new_subscriber.email
    click_button 'Subscribe!' 
      
    expect(page).to have_content 'Email can only be entered once a day'
  end
  
  scenario 'win a prize matching a condition' do   
    visit root_path   
    fill_in 'Email', with: new_subscriber.email
    click_button 'Subscribe!' 
    expect(page).to have_content 'Congratulations!!!'
  end
  
  scenario 'not match any condition' do   
    visit root_path   
    winner_subscriber = create(:subscriber)
    fill_in 'Email', with: new_subscriber.email
    click_button 'Subscribe!'  
    expect(page).to have_content 'You almost get it. Try again!'
  end
  
  scenario 'win a prize by carambola' do 
    # Create a new condition 
    list_condition = create(:list_condition)
    visit root_path 
    # Create subscriber #25 that win 2 conditions and create a carambola winner 
    fill_in 'Email', with: new_subscriber.email
    click_button 'Subscribe!'
    
    new_subscriber = build(:subscriber)
    visit root_path 
    # Create subscriber #26 (carambola winner) 
    fill_in 'Email', with: new_subscriber.email
    click_button 'Subscribe!' 
      
    expect(page).to have_content 'Congratulations!!!'
  end
end
