require 'spec_helper'

describe "prizes/index" do
  before(:each) do
    assign(:prizes, [
      stub_model(Prize,
        :prize_name => "Prize Name",
        :cost => 1,
        :stock => 2,
        :user_id => 3,
        :description => "MyText",
        :redemption_directions => "MyText"
      ),
      stub_model(Prize,
        :prize_name => "Prize Name",
        :cost => 1,
        :stock => 2,
        :user_id => 3,
        :description => "MyText",
        :redemption_directions => "MyText"
      )
    ])
  end

  it "renders a list of prizes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Prize Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
