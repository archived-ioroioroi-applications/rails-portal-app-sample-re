class ScrapCrazyWorker
  include Sidekiq::Worker

  def perform(*args)
    Rails.application.load_tasks
    Rake::Task['rapportal:scrap_curazy'].execute		# <- 例：Rake::Task['rapportal:put_hello'].execute
    Rake::Task['rapportal:scrap_curazy'].clear
  end
end
