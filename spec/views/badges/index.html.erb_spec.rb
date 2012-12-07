require 'spec_helper'

describe "badges/index" do
  before(:each) do
    assign(:badges, [
      stub_model(Badge,
        :user_id => 1,
        :prize_id => 2
      ),
      stub_model(Badge,
        :user_id => 1,
        :prize_id => 2
      )
    ])
  end

  it "renders a list of badges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
