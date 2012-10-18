require 'spec_helper'

describe "buy_ins/index" do
  before(:each) do
    assign(:buy_ins, [
      stub_model(BuyIn,
        :group_buy_in_id => 1,
        :user_id => 2
      ),
      stub_model(BuyIn,
        :group_buy_in_id => 1,
        :user_id => 2
      )
    ])
  end

  it "renders a list of buy_ins" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
