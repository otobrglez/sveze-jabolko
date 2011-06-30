module FeedHelper
  
  def apple_feeds_list
    return APPLE_FEEDS
  end
  
  def apple_feeds
    feed_urls = APPLE_FEEDS.map {|key,val| val["feed"]}
    feeds = Feedzirra::Feed.fetch_and_parse(feed_urls)
    feeds_out = APPLE_FEEDS.map do |key,val| 
      {
        key: key,
        title: val["title"],
        feed: val["feed"],
        feed_data: feeds[val["feed"]]
      }
    end
    feeds_out
  end
  
end
