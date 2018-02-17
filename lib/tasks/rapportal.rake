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
    article = []
    feed.entries.each do |entry|
      p article = {date: entry.published, category: category, link: entry.url, title: entry.title, icon: icon, source_link: source_link, source_title: source_title, source_icon: source_icon}
      begin
        Article.create_or_update(article)
      rescue => e
        puts e
        next
      end
    end

    #     article_record = {date: Time.current.strftime("%Y/%m/%d %H:%M:%S"), article_link: article[:href], article_title: article[:title], article_source_link: uri, article_source: article_source}
    #     begin
    #       Article.create(article_record)
    #       p "[Created] #{article_record[:article_title]}"
    #     rescue ActiveRecord::RecordNotUnique => e # 一意制約に引っかかったら
    #       p "[Skip] Record duplicate (#{article_record[:article_title]})"
    #       next
    #     rescue ActiveRecord::StatementInvalid => e  # Not Null制約に引っかかったら
    #       p "[Skip] Record null value in column article_title "
    #       next
    #     rescue => e # その他何かでエラーが起きたら
    #       p "[Skip] something wrong "
    #       p e
    #       next
    #     end
    #   end
    # end
    # p feed
  end

  desc "Create records from RSS by CuRAZY."
  task :scrap_gizmodo => :environment do |task, args|
    # RSSから取れないため、デフォルト値を設定 -------------------------------
    category = "it"
    source_link = "https://www.gizmodo.jp"
    source_title = "ギズモード・ジャパン"
    source_icon = "https://i.kinja-img.com/gawker-media/image/upload/s--ay4UlTaU--/wvhsuflzmeoo0zr9ex55.png"
    # -----------------------------------------------------------------
    uri = 'https://www.gizmodo.jp/index.xml'
    feed = Scrapping::Rssfeed.parse(uri)
    article = []
    feed.entries.each do |entry|
      p article = {date: entry.published, category: category, link: entry.url, title: entry.title, icon: entry.image, source_link: source_link, source_title: source_title, source_icon: source_icon}
      begin
        Article.create_or_update(article)
      rescue => e
        puts e
        next
      end
    end

    #     article_record = {date: Time.current.strftime("%Y/%m/%d %H:%M:%S"), article_link: article[:href], article_title: article[:title], article_source_link: uri, article_source: article_source}
    #     begin
    #       Article.create(article_record)
    #       p "[Created] #{article_record[:article_title]}"
    #     rescue ActiveRecord::RecordNotUnique => e # 一意制約に引っかかったら
    #       p "[Skip] Record duplicate (#{article_record[:article_title]})"
    #       next
    #     rescue ActiveRecord::StatementInvalid => e  # Not Null制約に引っかかったら
    #       p "[Skip] Record null value in column article_title "
    #       next
    #     rescue => e # その他何かでエラーが起きたら
    #       p "[Skip] something wrong "
    #       p e
    #       next
    #     end
    #   end
    # end
    # p feed
  end
end

# ユーザビリティ観点
# | 要素 | ステータス |
# |:--:|:--:|
# | 設定値 | 外部configファイル化 |   #<-サーバ再起動要否はなるべく不要が望ましい
# | 設定値 | デフォルト値 |
# | 設定値 | バリデーション（min, max, 許容文字, ...） |    #<- 参照：http://labs.opentone.co.jp/wp-content/uploads/2010/02/8a7a1b428edc1ed170f8556838542f41.pdf
