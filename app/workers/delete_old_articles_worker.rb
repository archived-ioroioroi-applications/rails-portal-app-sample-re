class DeleteOldArticlesWorker
  include Sidekiq::Worker

  def perform(*args)
    Article.delete_old_articles(14)
  end
end
