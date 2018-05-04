require 'feedjira'
require './app/modules/scrapping.rb'

# feed = Scrapping::Rssfeed.parse("http://feeds.youpouch.com/youpouch")
# puts "title         = " + feed.title
# puts "url           = " + feed.url
# puts "last_modified = " + feed.last_modified.to_s
#
# p feed.entries[0]

# # RSSから取れないものはデフォルト値を設定 -------------------------------
icon = "https://cdn.macaro-ni.jp/assets/img/top/macaroni_icon160.png"
source_link = "https://macaro-ni.jp/"
source_title = "macaroni"
source_icon = "https://cdn.macaro-ni.jp/assets/img/top/macaroni_icon160.png"
category = "gourmet"
# # -----------------------------------------------------------------
uri = 'https://macaro-ni.jp/rss/pickup.rss'
feed = Scrapping::Rssfeed.parse(uri)
# puts "title         = " + feed.entries[0].title
# puts "url           = " + feed.entries[0].url
# puts "last_modified = " + feed.entries[0].last_modified.to_s
article = {}
feed.entries.each do |entry|
  # p entry
  p entry.title
  p entry.url
  p entry.published
  # p entry.image
  # p entry.categories
  # RSSで取得したカテゴリーから分類 ------------------------------------
  # if entry.categories.include?("グルメ")
  #   category = "gourmet"
  # elsif entry.categories.include?("エンタメ")
  #   category = "column"
  # else
  #   category = "column"
  # end
  # ---------------------------------------------------------------
  # 記事アイコンを記事リンク先から取得. なければデフォルトアイコンを使用 -----
  begin
    p icon = Scrapping::Html.get_all(entry.url).css('.article_image').css('img')[0].attribute('src').value
  rescue => e
    p "iconが取れない動画系はいったん取りません！"
    next
  end
  # ---------------------------------------------------------------
  # p article = {category: category, link: entry.url}
  p article = {date: entry.published, category: category, link: entry.url, title: entry.title, icon: icon, source_link: source_link, source_title: source_title, source_icon: source_icon}
end
