require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    config.logger = ActiveSupport::Logger.new("log/sidekiq_dev.log", 5, 1.megabytes)
    config.logger.formatter = proc do |severity, datetime, progname, msg|
      "[#{datetime}:#{progname}] #{severity}\t-- : #{msg}\n"
    end
    # Sidekiq.schedule = YAML.load_file(File.expand_path('../../sidekiq.yml', __FILE__))
    # Sidekiq::Scheduler.reload_schedule!
  end
end
