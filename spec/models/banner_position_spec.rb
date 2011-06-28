require 'spec_helper'

describe BannerPosition do
  it "has key and value" do
    @bp = BannerPosition.new('y','Y')
    @bp.should respond_to(:key)
    @bp.should respond_to(:value)
    
    @bp.key.should == "y"
    @bp.value.should == 'Y'
  end
  
  it "has method \"positions\" " do
    positions = BannerPosition.positions
    positions.size.should == 3
  end
end