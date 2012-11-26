require 'spec_helper'

describe "prize_codes/index" do
  before(:each) do
    assign(:prize_codes, [
      stub_model(PrizeCode,
        :user_id => 1,
        :prize_id => 2,
        :code => "Code"
      ),
      stub_model(PrizeCode,
        :user_id => 1,
        :prize_id => 2,
        :code => "Code"
      )
    ])
  end

  it "renders a list of prize_codes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Code".to_s, :count => 2
  end
end
