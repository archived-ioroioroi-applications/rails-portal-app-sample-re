require 'open-uri'
# require 'nokogiri'
# require 'feedjira'
# ↑ Gemでいれたライブラリのrequire は config/application.rb で担ってるから不要

module Scrapping
  class Rssfeed
    def self.parse(uri)
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
    # エラー観点
    # | 要素 | ステータス |
    # |:--:|:--:|
    # | URL | 空 |
    # | URL | 文字列でない（型違い） |
    # | URL | 不正なプロトコル(http:// or https:// で始まらない) |
    # | URL | 存在しないURL |
    # | URL | URL形式をとっていない |
    # | URL | RSSサービスでない |
  end

  class Html
    def self.get_all(uri)    # using Nokogiri
      if uri.split("//")[0] == "http:" || uri.split("//")[0] == "https:"
        charset = nil
        html = open(uri) do |f|
          charset = f.charset
          f.read
        end
        doc = Nokogiri::HTML.parse(html, charset)
        return doc
      else
        return 0
      end
    end
    def self.get_host(uri)
      if uri.split("//")[0] == "http:" || uri.split("//")[0] == "https:"
        scheme = uri.scan(%r{^(.+?)/})
        fqdn = uri.scan(%r{//(.+?)/})
        fqdn = uri.scan(%r{//(.+?)$}) if fqdn == []
        host = scheme[0][0] + "//" + fqdn[0][0]
        return host
      else
        return 0
      end
    end
    def self.get_scheme(uri)
      if uri.split("//")[0] == "http:"
        scheme = "http:"
      elsif uri.split("//")[0] == "https:"
        scheme = "https:"
      else
        return 0
      end
      return scheme
    end
    def self.get_fqdn(uri)
      fqdn = uri.scan(%r{//(.+?)/})
      if uri.split("//")[0] == "http:" || uri.split("//")[0] == "https:"
        fqdn = uri.scan(%r{//(.+?)/})
        fqdn = uri.scan(%r{//(.+?)$}) if fqdn == []
        return fqdn
      else
        return 0
      end
    end

    def self.get_img(uri, depth)    # using Nokogiri
      host = self.get_host(uri)
      scheme = self.get_scheme(uri)
      doc = self.get_html(uri)
      doc_imgs = []
      if doc == 0
        return doc_imgs
      end
      doc.css('img').each do |d|
        if d.attribute('src').value.slice(0,2) == "//"
          doc_imgs.push(scheme + d.attribute('src').value)
        elsif d.attribute('src').value.slice(0,1) == "/"
          doc_imgs.push(host + d.attribute('src').value)
        else
          doc_imgs.push(d.attribute('src').value)
        end
      end
      return doc_imgs
    end

    def self.get_img_selenium(uri, depth)    # using Nokogiri, Selenium
      host = self.get_host(uri)
      scheme = self.get_scheme(uri)
      ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"
      caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {binary: '/usr/bin/google-chrome', args: ["--headless", "--disable-gpu", "--user-agent=#{ua}", "window-size=1280x8000"]})
      driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps
      begin
        driver.navigate.to uri
        sleep 0.5
        doc = Nokogiri::HTML.parse(driver.page_source)
        doc_imgs = []
        if doc == 0
          return doc_imgs
        end
        doc.css('img').each do |d|
          if d.attribute('src').value.slice(0,2) == "//"
            doc_imgs.push(scheme + d.attribute('src').value)
          elsif d.attribute('src').value.slice(0,1) == "/"
            doc_imgs.push(host + d.attribute('src').value)
          else
            doc_imgs.push(d.attribute('src').value)
          end
        end
        return doc_imgs
      rescue => e
        logger = Logger.new('log/error.log', 3, 1024 * 1024)
        logger.error e
        return nil
      end
    end
  end
end
