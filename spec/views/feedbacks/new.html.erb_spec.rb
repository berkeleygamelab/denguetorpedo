require 'spec_helper'

describe "feedbacks/new" do
  before(:each) do
    assign(:feedback, stub_model(Feedback,
      :title => "MyString",
      :email => "MyString",
      :name => "MyString",
      :message => "MyText"
    ).as_new_record)
  end

  it "renders new feedback form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", feedbacks_path, "post" do
      assert_select "input#feedback_title[name=?]", "feedback[title]"
      assert_select "input#feedback_email[name=?]", "feedback[email]"
      assert_select "input#feedback_name[name=?]", "feedback[name]"
      assert_select "textarea#feedback_message[name=?]", "feedback[message]"
    end
  end
end
