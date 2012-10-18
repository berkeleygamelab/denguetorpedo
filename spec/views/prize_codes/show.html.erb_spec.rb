require 'spec_helper'

describe "prize_codes/show" do
  before(:each) do
    @prize_code = assign(:prize_code, stub_model(PrizeCode,
      :user_id => 1,
      :prize_id => 2,
      :code => "Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Code/)
  end
end
