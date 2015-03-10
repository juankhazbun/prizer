module SessionHelpers
  
  # Helper to sign up in the admin section
  def sign_up_with(user)
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'
  end
  
end