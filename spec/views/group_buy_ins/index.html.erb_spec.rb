require 'spec_helper'

describe "group_buy_ins/index" do
  before(:each) do
    assign(:group_buy_ins, [
      stub_model(GroupBuyIn,
        :prize_id => 1,
        :user_id => 2,
        :group_size => 3
      ),
      stub_model(GroupBuyIn,
        :prize_id => 1,
        :user_id => 2,
        :group_size => 3
      )
    ])
  end

  it "renders a list of group_buy_ins" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
