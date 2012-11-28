require 'spec_helper'

describe "badges/edit" do
  before(:each) do
    @badge = assign(:badge, stub_model(Badge,
      :user_id => 1,
      :prize_id => 1
    ))
  end

  it "renders the edit badge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => badges_path(@badge), :method => "post" do
      assert_select "input#badge_user_id", :name => "badge[user_id]"
      assert_select "input#badge_prize_id", :name => "badge[prize_id]"
    end
  end
end
