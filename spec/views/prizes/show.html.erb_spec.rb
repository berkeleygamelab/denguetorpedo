require 'spec_helper'

describe "prizes/show" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @house = FactoryGirl.create(:house)
    @user.house = @house
    @prize = assign(:prize, stub_model(Prize,
      :prize_name => "Prize Name",
      :cost => 1,
      :stock => 2,
      :user_id => @user.id,
      :description => "MyText",
      :redemption_directions => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Prize Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
