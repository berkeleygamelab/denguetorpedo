require 'spec_helper'

describe "prize_codes/edit" do
  before(:each) do
    @prize_code = assign(:prize_code, stub_model(PrizeCode,
      :user_id => 1,
      :prize_id => 1,
      :code => "MyString"
    ))
  end

  it "renders the edit prize_code form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => prize_codes_path(@prize_code), :method => "post" do
      assert_select "input#prize_code_user_id", :name => "prize_code[user_id]"
      assert_select "input#prize_code_prize_id", :name => "prize_code[prize_id]"
      assert_select "input#prize_code_code", :name => "prize_code[code]"
    end
  end
end
