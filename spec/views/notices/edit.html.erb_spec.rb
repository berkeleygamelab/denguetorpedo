require 'spec_helper'

describe "notices/edit" do
  before(:each) do
    @notice = assign(:notice, stub_model(Notice,
      :title => "MyString",
      :description => "MyText",
      :location => "MyString"
    ))
    @neighborhoods = Neighborhood.all
  end

  it "renders the edit notice form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", notice_path(@notice), "post" do
      assert_select "input#notice_title[name=?]", "notice[title]"
      assert_select "textarea#notice_description[name=?]", "notice[description]"
      assert_select "input#notice_location[name=?]", "notice[location]"
    end
  end
end
