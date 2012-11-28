require 'spec_helper'

describe "badges/show" do
  before(:each) do
    @badge = assign(:badge, stub_model(Badge,
      :user_id => 1,
      :prize_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
