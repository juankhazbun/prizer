require 'rails_helper'

RSpec.describe "prizes/new", :type => :view do
  before(:each) do
    assign(:prize, Prize.new(
      :description => "MyString",
      :existences => 1
    ))
  end

  it "renders new prize form" do
    render

    assert_select "form[action=?][method=?]", prizes_path, "post" do

      assert_select "input#prize_description[name=?]", "prize[description]"

      assert_select "input#prize_existences[name=?]", "prize[existences]"
    end
  end
end
