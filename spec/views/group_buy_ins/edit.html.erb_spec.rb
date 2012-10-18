require 'spec_helper'

describe "group_buy_ins/edit" do
  before(:each) do
    @group_buy_in = assign(:group_buy_in, stub_model(GroupBuyIn,
      :prize_id => 1,
      :user_id => 1,
      :group_size => 1
    ))
  end

  it "renders the edit group_buy_in form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => group_buy_ins_path(@group_buy_in), :method => "post" do
      assert_select "input#group_buy_in_prize_id", :name => "group_buy_in[prize_id]"
      assert_select "input#group_buy_in_user_id", :name => "group_buy_in[user_id]"
      assert_select "input#group_buy_in_group_size", :name => "group_buy_in[group_size]"
    end
  end
end
