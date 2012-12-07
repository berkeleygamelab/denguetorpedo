require 'spec_helper'

describe "badges/new" do
  before(:each) do
    assign(:badge, stub_model(Badge,
      :user_id => 1,
      :prize_id => 1
    ).as_new_record)
  end

  it "renders new badge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => badges_path, :method => "post" do
      assert_select "input#badge_user_id", :name => "badge[user_id]"
      assert_select "input#badge_prize_id", :name => "badge[prize_id]"
    end
  end
end
