require 'feedjira'

def parse_rss(uri)
  begin
    feed = Feedjira::Feed.fetch_and_parse(uri)
  rescue Faraday::ConnectionFailed  # 存在しないURL
    e = "#{Time.now} - [Error] URLが開けません. "
    return e
  rescue URI::InvalidURIError # URLが空かただの文字列
    e = "#{Time.now} - [Error] 不正なURLの可能性があります. URLが空でないこと、またはURL形式で正しく記述されていることを確認してください."
    return e
  rescue NoMethodError # URLが不正
    e = "#{Time.now} - [Error] 不正なURLの可能性があります. http://またはhttps://から始まる正規のURLであることを確認してください."
    return e
  rescue Feedjira::NoParserAvailable # FeedjiraでParseできないURL
    e = "#{Time.now} - [Error] 不正なURLの可能性があります. RSSサービスを提供しているURLであることを確認してください."
    return e
  rescue ArgumentError # URLが文字列でない（int型など）
    e = "#{Time.now} - [Error] 不正なURLの可能性があります. URL文字列であることを確認してください."
    return e
  rescue => e # その他
    return "#{Time.now} - [Error] 予期せぬエラーです. #{e}"
  end
  return feed
end

feed = parse_rss("https://www.gizmodo.jp/index.xml")
# p feeds.entries[0]


# puts "title         = " + feed.title
# puts "url           = " + feed.url
# puts "last_modified = " + feed.last_modified.to_s
#
# p feed.entries[0]

feed.entries.each do |entry|
  puts "-----"
  puts entry.title
  puts entry.url
  puts entry.categories
  puts entry.image
  puts entry.published.strftime("%Y-%m-%d %H:%M:%S")
end
