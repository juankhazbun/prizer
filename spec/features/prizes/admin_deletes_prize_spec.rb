require 'rails_helper'

feature 'Admin deletes a prize' do
  
  let!(:admin) { create(:admin_user) }  
  let!(:prize) { create(:prize) }  
  
  scenario do    
    admin = build(:admin_user)
    sign_up_with admin    
    visit admin_prizes_path    
    click_link 'Delete'    
    expect(page).to have_content 'Prize was successfully destroyed.'
    expect(page).to_not have_content prize.description
  end
end
