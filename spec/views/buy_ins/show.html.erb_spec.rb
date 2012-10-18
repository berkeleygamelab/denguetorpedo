require 'spec_helper'

describe "buy_ins/show" do
  before(:each) do
    @buy_in = assign(:buy_in, stub_model(BuyIn,
      :group_buy_in_id => 1,
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
