require 'feedjira'
require './app/modules/scrapping.rb'

# feed = parse_rss("https://rocketnews24.com/feed/")
# p feeds.entries[0]
# puts "title         = " + feed.title
# puts "url           = " + feed.url
# puts "last_modified = " + feed.last_modified.to_s
#
# p feed.entries[0]

# RSSから取れないため、デフォルト値を設定 -------------------------------
icon = "https://static.curazy.com/image/curazy-v03/logo_curazy.png"
source_link = "https://curazy.com"
source_title = "笑うメディア クレイジー"
source_icon = "https://static.curazy.com/image/curazy-v03/logo_curazy.png"
# -----------------------------------------------------------------
uri = 'https://curazy.com/feed'
feed = Scrapping::Rssfeed.parse(uri)
article = {}
feed.entries.each do |entry|
  p entry.categories
  # RSSで取得したカテゴリーから分類 ------------------------------------
  if entry.categories.include?("料理")
    category = "gourmet"
  elsif entry.categories.include?("レシピ")
    category = "gourmet"
  elsif entry.categories.include?("お菓子")
    category = "gourmet"
  else
    category = "column"
  end
  # ---------------------------------------------------------------
  # 記事アイコンを記事リンク先から取得. なければデフォルトアイコンを使用 -----
  begin
    icon = Scrapping::Html.get_all(entry.url).css('.entry-thumbnail').css('img')[0].attribute('src').value
  rescue => e
  end
  # ---------------------------------------------------------------
  # p article = {category: category, link: entry.url}
  p article = {date: entry.published, category: category, link: entry.url, title: entry.title, icon: icon, source_link: source_link, source_title: source_title, source_icon: source_icon}
end
