# frozen_string_literal: true

module API
  class ApiLogger < Logger
    def initialize
      super(GrapeLogging::MultiIO.new(STDOUT, log_file))
    end

    private
      def create_log_file
        file = file_from_path
        file.sync = true
        file
      end

      def log_path
        "#{Settings.logger.path || "logs"}/#{Env.rack}.log"
      end

      def file_from_path
        dirname = File.dirname(log_path)
        FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
        File.open(log_path, "a")
      end

      def log_file
        @log_file ||= create_log_file
      end
  end
end
