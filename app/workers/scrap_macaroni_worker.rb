class ScrapMacaroniWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    Rails.application.load_tasks
    Rake::Task['rapportal:scrap_macaroni'].execute		# <- 例：Rake::Task['rapportal:put_hello'].execute
    Rake::Task['rapportal:scrap_macaroni'].clear
  end
end
