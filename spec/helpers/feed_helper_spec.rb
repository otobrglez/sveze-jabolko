require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the FeedHelper. For example:
#
# describe FeedHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe FeedHelper do
  
  it "has some configuration" do
    APPLE_FEEDS.should_not == nil
  end
  
  describe "apple_feeds" do
    it "returns nil" do
      feeds = helper.apple_feeds
      feeds.should_not == nil
      feeds.size.should == APPLE_FEEDS.size
      feeds.first[:feed_data].entries.first.title.should_not == nil
    end
  
  end
  
end
