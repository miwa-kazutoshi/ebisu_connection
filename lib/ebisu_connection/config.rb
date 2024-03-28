require 'yaml'
require 'erb'

module EbisuConnection
  class Config
    include Enumerable

    class << self
      attr_writer :replica_file

      def config
        return @config if defined?(@config)

        conf = YAML.load(erb2yml)
        @config = conf[EbisuConnection.env.to_s] || {}
      end

      private

      def erb2yml
        ERB.new(File.read(replica_file)).result
      end

      def replica_file
        return @replica_file if @replica_file

        raise "nothing replica_file. You have to set a file path using EbisuConnection.replica_file= method" unless defined?(Rails)

        file = %w(yml yaml).map{|ext| Rails.root.join("config/replica.#{ext}").to_s }.detect {|f| File.exist?(f) }
        return file if file

        raise "nothing replica_file. You have to put a config/replica.yml file"
      end
    end

    def initialize(spec_name)
      @conf = load_config(spec_name)
    end

    def each(&block)
      @conf.each(&block)
    end

    private

    def load_config(spec_name)
      c = self.class.config

      if c.is_a?(Hash)
        c[spec_name] || c
      else
        c
      end
    end
  end
end
