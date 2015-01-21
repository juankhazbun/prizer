require 'rails_helper'

RSpec.describe "prizes/show", :type => :view do
  before(:each) do
    @prize = assign(:prize, Prize.create!(
      :description => "Description",
      :existences => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/1/)
  end
end
