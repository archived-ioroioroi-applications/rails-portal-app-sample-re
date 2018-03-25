namespace :rapportal do
  desc "Create records from RSS by CuRAZY."
  task :scrap_curazy => :environment do |task, args|
    # RSSから取れないため、デフォルト値を設定 -------------------------------
    icon = "https://static.curazy.com/image/curazy-v03/logo_curazy.png"
    category = "column"
    source_link = "https://curazy.com"
    source_title = "笑うメディア クレイジー"
    source_icon = "https://static.curazy.com/image/curazy-v03/logo_curazy.png"
    # -----------------------------------------------------------------
    uri = 'https://curazy.com/feed'
    feed = Scrapping::Rssfeed.parse(uri)
    article = {}
    feed.entries.each do |entry|
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
      p article = {date: entry.published, category: category, link: entry.url, title: entry.title, icon: icon, source_link: source_link, source_title: source_title, source_icon: source_icon}
      begin
        Article.create_or_update(article)
      rescue => e
        puts e
        next
      end
    end
  end

  desc "Create records from RSS by Gizmodo."
  task :scrap_gizmodo => :environment do |task, args|
    # RSSから取れないため、デフォルト値を設定 -------------------------------
    category = "it"
    source_link = "https://www.gizmodo.jp"
    source_title = "ギズモード・ジャパン"
    source_icon = "https://i.kinja-img.com/gawker-media/image/upload/s--ay4UlTaU--/wvhsuflzmeoo0zr9ex55.png"
    # -----------------------------------------------------------------
    uri = 'https://www.gizmodo.jp/index.xml'
    feed = Scrapping::Rssfeed.parse(uri)
    article = {}
    feed.entries.each do |entry|
      p article = {date: entry.published, category: category, link: entry.url, title: entry.title, icon: entry.image, source_link: source_link, source_title: source_title, source_icon: source_icon}
      begin
        Article.create_or_update(article)
      rescue => e
        puts e
        next
      end
    end
  end

  desc "Create records from RSS by Rocketnews24."
  task :scrap_rocketnews => :environment do |task, args|
    # RSSから取れないため、デフォルト値を設定 -------------------------------
    source_link = "https://rocketnews24.com"
    source_title = "RocketNews24"
    source_icon = nil
    # -----------------------------------------------------------------
    uri = 'https://rocketnews24.com/feed/'
    feed = Scrapping::Rssfeed.parse(uri)
    article = {}
    feed.entries.each do |entry|
      # RSSで取得したカテゴリーから分類 ------------------------------------
      if entry.categories.include?("コラム")
        category = "column"
      elsif entry.categories.include?("生活")
        category = "column"
      elsif entry.categories.include?("知識")
        category = "column"
      elsif entry.categories.include?("芸能")
        category = "column"
      elsif entry.categories.include?("ガジェット")
        category = "it"
      elsif entry.categories.include?("IT")
        category = "it"
      elsif entry.categories.include?("グルメ")
        category = "gourmet"
      else
        p "該当しないカテゴリー"  # 上記に該当しなければその記事を取得しない
        next
      end
      # ---------------------------------------------------------------
      p article = {date: entry.published, category: category, link: entry.url, title: entry.title, icon: entry.image, source_link: source_link, source_title: source_title, source_icon: source_icon}
      begin
        Article.create_or_update(article)
      rescue => e
        puts e
        next
      end
    end
  end

  desc "Testtasks for Debug."
  task :put_hello => :environment do |task, args|
    message = "Hello world. This is the debugging"
    Utility::Log.output_success(message)
  end

end

# ユーザビリティ観点
# | 要素 | ステータス |
# |:--:|:--:|
# | 設定値 | 外部configファイル化 |   #<-サーバ再起動要否はなるべく不要が望ましい
# | 設定値 | デフォルト値 |
# | 設定値 | バリデーション（min, max, 許容文字, ...） |    #<- 参照：http://labs.opentone.co.jp/wp-content/uploads/2010/02/8a7a1b428edc1ed170f8556838542f41.pdf
