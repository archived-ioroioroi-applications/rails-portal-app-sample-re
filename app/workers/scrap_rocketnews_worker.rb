class ScrapRocketnewsWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    Rails.application.load_tasks
    Rake::Task['rapportal:scrap_rocketnews'].execute		# <- 例：Rake::Task['rapportal:put_hello'].execute
    Rake::Task['rapportal:scrap_rocketnews'].clear
  end
end
