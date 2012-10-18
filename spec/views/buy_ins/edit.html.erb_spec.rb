require 'spec_helper'

describe "buy_ins/edit" do
  before(:each) do
    @buy_in = assign(:buy_in, stub_model(BuyIn,
      :group_buy_in_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit buy_in form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => buy_ins_path(@buy_in), :method => "post" do
      assert_select "input#buy_in_group_buy_in_id", :name => "buy_in[group_buy_in_id]"
      assert_select "input#buy_in_user_id", :name => "buy_in[user_id]"
    end
  end
end
