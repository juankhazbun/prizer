require 'rails_helper'

RSpec.describe "prizes/index", :type => :view do
  before(:each) do
    assign(:prizes, [
      Prize.create!(
        :description => "Description",
        :existences => 1
      ),
      Prize.create!(
        :description => "Description",
        :existences => 1
      )
    ])
  end

  it "renders a list of prizes" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
