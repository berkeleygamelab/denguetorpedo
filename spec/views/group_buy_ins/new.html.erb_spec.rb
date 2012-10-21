require 'spec_helper'

describe "group_buy_ins/new" do
  before(:each) do
    assign(:group_buy_in, stub_model(GroupBuyIn,
      :prize_id => 1,
      :user_id => 1,
      :group_size => 1
    ).as_new_record)
  end

  it "renders new group_buy_in form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => group_buy_ins_path, :method => "post" do
      assert_select "input#group_buy_in_prize_id", :name => "group_buy_in[prize_id]"
      assert_select "input#group_buy_in_user_id", :name => "group_buy_in[user_id]"
      assert_select "input#group_buy_in_group_size", :name => "group_buy_in[group_size]"
    end
  end
end