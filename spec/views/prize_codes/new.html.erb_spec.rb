require 'spec_helper'

describe "prize_codes/new" do
  before(:each) do
    assign(:prize_code, stub_model(PrizeCode,
      :user_id => 1,
      :prize_id => 1,
      :code => "MyString"
    ).as_new_record)
  end

  it "renders new prize_code form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => prize_codes_path, :method => "post" do
      assert_select "input#prize_code_user_id", :name => "prize_code[user_id]"
      assert_select "input#prize_code_prize_id", :name => "prize_code[prize_id]"
      assert_select "input#prize_code_code", :name => "prize_code[code]"
    end
  end
end
