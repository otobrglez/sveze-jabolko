require 'spec_helper'

describe Banner do
  
  before(:each) do
    Banner.delete_all
    @banner = Banner.new
  end

  it "has some required attributes" do
    @banner ||= Banner.new
    @banner.should_not be_valid
    
    @banner.should have(2).error_on(:image_url)
    @banner.image_url = "http://i.fanpix.net/images/orig/b/6/b6prb1yqe89ap6b9.jpg"
    @banner.should have(2).error_on(:link)
    @banner.link = "http://opalab.com"
    
    @banner.width = 0
    @banner.height = 0
    
    @banner.should have(1).error_on(:width)
    @banner.width = 100
    @banner.should have(1).error_on(:height)
    @banner.height = 100
    
    @banner.should have(1).error_on(:from_date)
    @banner.from_date = DateTime.now.to_date
    @banner.should have(1).error_on(:to_date)
    @banner.to_date = (DateTime.now+1.week).to_date
    
    @banner.should have(1).error_on(:position)
    @banner.position = 'a'
    
    @banner.number_of_clicks = -1
    @banner.should have(1).error_on(:number_of_clicks)
    @banner.number_of_clicks = 0
    @banner.should have(0).error_on(:number_of_clicks)
    
    
    @banner.should be_valid
  end
  
  it "has method for_position" do
    
    5.times do |t|
      @banner = Factory(
        :banner,
        :position => 'a',
        :from_date  => (DateTime.now-2.days).to_date,
        :to_date    => (DateTime.now+10.days).to_date,
        :hidden => 0
      )
      @banner.should be_valid
    end
    
    # Change last banner visibility
    bl = Banner.last
    bl.hidden = 1
    bl.save
    
    Banner.all.count.should == 5
    
    4.times do |t|
      @banner = Factory(
        :banner,
        :position => 'b',
        :width => 125,
        :height => 125,
        :from_date => (DateTime.now-2.days).to_date,
        :to_date =>   (DateTime.now+10.days).to_date,
        :hidden => 0
      )
    end
    
    Banner.should respond_to(:for_position)
    Banner.all.count.should == 5+4
    
    # banners_a = Banner.for_position('a')
    # banners_a.count.should == 4
    # 
    # banners_b = Banner.for_position('b')
    # banners_b.count.should == 4
  end
  
  it "for_position uses time" do
    @banner = Factory(:banner, :position => 'a',
      :from_date => (DateTime.now+1.day).to_date,
      :to_date => (DateTime.now+14.days).to_date)
    
    @banner.should be_valid
    
    banners_a = Banner.for_position('a')
    banners_a.count.should == 0
    
    Banner.for_position('a',
      (DateTime.now+1.day).to_date).count.should == 1
    
  end

end
