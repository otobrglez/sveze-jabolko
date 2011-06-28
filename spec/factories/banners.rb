Factory.define :banner, :class => Banner do |t|
    t.image_url "http://i.fanpix.net/images/orig/b/6/b6prb1yqe89ap6b9.jpg"
    t.link      "http://www.fanpix.net/picture-gallery/robert-duvall-picture-12034220.htm"
    t.title     "Robert Duvall"
    t.position   "a"
    t.number_of_clicks  0
    t.width             256
    t.height            148
    t.from_date  (DateTime.now-10.day).to_date
    t.to_date    (DateTime.now+10.days).to_date
    t.hidden 0
    
    #t.created_at
    #t.updated_at
    #t.datetime "from"
    #t.datetime "to"
end
