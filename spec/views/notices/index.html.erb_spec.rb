require 'spec_helper'

describe "notices/index" do
  before(:each) do
    assign(:notices, [
      stub_model(Notice,
        :title => "Title",
        :description => "MyText",
        :location => "Location"
      ),
      stub_model(Notice,
        :title => "Title",
        :description => "MyText",
        :location => "Location"
      )
    ])
  end

  it "renders a list of notices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
