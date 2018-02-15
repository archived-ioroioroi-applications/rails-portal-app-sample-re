class Article < ApplicationRecord
  # validates :link, presence: true, uniqueness: true  # 記事リンクは存在しないとエラーかつ一意でないとエラー
  # validates :title, presence: true  # 記事タイトルは存在しないとエラー
  # これはモデルに対するユニーク制約. これだけだと不完全なのでmigrationファイルにも制約をかける必要あり.
  ## モデルでバリデーションかけると、制約にひっかかったときにエラーが帰ってこないので一旦DBのバリデーションのみで.


  def self.create_or_update(data) # article を更新する際にいちいちcreateかupdateかの条件分岐を指定するのが面倒なので.
    begin
      record = Article.where(
        :link => data[:link]  # 登録しようとしているレコードのlinkと同じlinkを持つレコードが既にあったらrecordに格納.
      )
      if record.exists? # recordに格納されるレコードが既にあったらそのレコードをupdateする.
        record.update_all(data)
        puts "#{Time.now} - [Success] Record updated(#{data[:link]}, #{data[:title]})"
      else
        Article.create(data)
        puts "#{Time.now} - [Success] Record created(#{data[:link]}, #{data[:title]})"
      end
    rescue ActiveRecord::RecordNotUnique => e # 一意制約に引っかかったら
      puts "#{Time.now} - [Skip] Record duplicate (#{data[:link]}, #{data[:title]})"
    rescue ActiveRecord::StatementInvalid => e  # Not Null制約に引っかかったら
      puts "#{Time.now} - [Skip] Record null value in article (#{e}) "
    rescue => e # その他何かでエラーが起きたら
      puts "#{Time.now} - [Skip] something wrong. (#{e}) "
      puts e
    end
  end

  private

  # def self.set_default_icon
  #   # リンク記事の画像が取得できなかったらデフォルトアイコンを入れてテーブルにインサート
  # end
end
