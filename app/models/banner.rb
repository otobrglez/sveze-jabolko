class Banner < ActiveRecord::Base

  validates_presence_of [:image_url,:link,:width,:height,:from_date,:to_date,:position]
  validates_format_of [:link,:image_url],
    :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  validates_numericality_of [:width,:height], :greater_than => 0
  validates_numericality_of [:number_of_clicks], :greater_than => -1
  
  def to_s
    return "#{self.link}" if title == nil || title == ""
    return "#{self.title}"
  end

  def self.for_position(position = 'a', for_date=DateTime.now.to_date)
    where("position = ?", position)
    .where("? between from_date AND to_date", for_date)
    .where("hidden = 0")
    .order("RANDOM()")
    .limit(
      [(2 if position=='a'),
        (4 if position=='b'),
        (1 if position=='c')].compact.first
    )
  end
  
end
