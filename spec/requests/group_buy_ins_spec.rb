require 'spec_helper'

describe "GroupBuyIns" do
  describe "GET /group_buy_ins" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get group_buy_ins_path
      response.status.should be(200)
    end
  end
end
