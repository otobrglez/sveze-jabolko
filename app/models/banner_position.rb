class BannerPosition

  attr_accessor :key,:value
  
  def initialize(key,value)
    self.key, self.value = key, value
  end
  
  def self.positions
    [
      BannerPosition.new('a','A'),
      BannerPosition.new('b','B'),
      BannerPosition.new('c','C')
    ]
  end

  def to_s
    "#{self.key}"
  end

end