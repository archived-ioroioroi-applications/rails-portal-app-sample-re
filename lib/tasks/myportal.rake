namespace :myportal do
  namespace :scrap do

    desc "Exec task to scrap Gizmode."
    task :gizmode => :environment do |task, args|

      # require_relative '../articles_scraper/scrap_html.rb'  # 相対パスの記法
      require 'articles_scraper/scrap_html.rb'
      article_source = "ギズモード・ジャパン"
      uri = 'http://www.gizmodo.jp/'
      uri_html = Scraper::Html.get(uri)
      doc = Scraper::Html.parse(uri_html[:html], uri_html[:charset])
      doc.css('.gz-block').css('a').each do |article|
        if article[:href].slice(0,4) != "http"  # リンクの先頭が http でなければでなければローカルを指定したリンクなのでDBにいれない
          p "this link is no url"
        else
          article_record = {date: Time.current.strftime("%Y/%m/%d %H:%M:%S"), article_link: article[:href], article_title: article[:title], article_source_link: uri, article_source: article_source}
          begin
            Article.create(article_record)
            p "[Created] #{article_record[:article_title]}"
          rescue ActiveRecord::RecordNotUnique => e # 一意制約に引っかかったら
            p "[Skip] Record duplicate (#{article_record[:article_title]})"
            next
          rescue ActiveRecord::StatementInvalid => e  # Not Null制約に引っかかったら
            p "[Skip] Record null value in column article_title "
            next
          rescue => e # その他何かでエラーが起きたら
            p "[Skip] something wrong "
            p e
            next
          end
        end
      end
    end


    desc "Exec task to insert test datas to DB."
    task :testdata => :environment do |task, args|

      test_day = Time.local(2017,1,1,0,0,0)
      for i in 1..999 do
        test_day = test_day + 12*60*60
        test_number = sprintf("%03d",i)
        test_article_link = "ArticleLink#{test_number}"
        test_article_title = "ArticleTitle#{test_number}"
        test_article_source_link = "ArticleSourceLink#{test_number}"
        test_article_source = "ArticleSource#{test_number}"
        test_article_record = {date: test_day.strftime("%Y/%m/%d %H:%M:%S"), article_link: test_article_link, article_title: test_article_title, article_source_link: test_article_source_link, article_source: test_article_source}
        Article.create(test_article_record)
        p "[Created] #{test_article_record[:article_title]}"
      end

    end


  end
end
