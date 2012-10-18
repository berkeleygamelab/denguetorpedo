require 'spec_helper'

describe "group_buy_ins/show" do
  before(:each) do
    @group_buy_in = assign(:group_buy_in, stub_model(GroupBuyIn,
      :prize_id => 1,
      :user_id => 2,
      :group_size => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
