require 'sidekiq-scheduler'


class HelloWorld
  include Sidekiq::Worker

  def perform
    puts 'Hello wonderful'
  end
end
