require 'rails_helper'

RSpec.describe "prizes/edit", :type => :view do
  before(:each) do
    @prize = assign(:prize, Prize.create!(
      :description => "MyString",
      :existences => 1
    ))
  end

  it "renders the edit prize form" do
    render

    assert_select "form[action=?][method=?]", prize_path(@prize), "post" do

      assert_select "input#prize_description[name=?]", "prize[description]"

      assert_select "input#prize_existences[name=?]", "prize[existences]"
    end
  end
end
