module Utility
  class Log
    def self.output_success(s)
      logger = Logger.new('log/success.log', 3, 1024 * 1024)
      logger.formatter = proc do |severity, datetime, progname, msg|
        "[#{datetime}:#{progname}] #{severity}\t-- : #{msg}\n"
      end
      logger.info s
      p s
    end

    def self.output_error(e,*error_msg)
      logger = Logger.new('log/error.log', 3, 1024 * 1024)
      logger.formatter = proc do |severity, datetime, progname, msg|
        "[#{datetime}:#{progname}] #{severity}\t-- : #{msg}\n"
      end
      error_msg.each do |em|
        logger.error em
      end
      logger.error e.class
      logger.error e.message
      logger.error e.backtrace.join("\n")
      p "[SystemError!] Check ErrorLog! (log/error.log)"
    end

    def self.output_error_only_message(msg)
      logger = Logger.new('log/error.log', 3, 1024 * 1024)
      logger.formatter = proc do |severity, datetime, progname, msg|
        "[#{datetime}:#{progname}] #{severity}\t-- : #{msg}\n"
      end
      logger.error msg
      p "[SystemError!] Check ErrorLog! (log/error.log)"
    end
  end

  class Task
    def self.lock(task_name)
      key = 0
      eval "@lock_#{task_name} = 0"
      loop do
        sleep 0.5
        eval "if @lock_#{task_name} == 1; key = 1; end;"
        break if key == 1
      end
    end

    def self.unlock(task_name)
      eval "@lock_#{task_name} = 1"
    end
  end
end
