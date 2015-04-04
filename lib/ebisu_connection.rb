require "fresh_connection"
require 'ebisu_connection/conf_file'
require 'ebisu_connection/connection_manager'

module EbisuConnection
  class << self
    attr_writer :env

    def slaves_file=(file)
      ConfFile.slaves_file = file
    end

    def check_interval=(interval)
      ConfFile.check_interval = interval
    end

    def env
      @env ||= defined?(Rails) && Rails.env || ENV["RAILS_ENV"] || ENV["RACK_ENV"]
    end
  end
end

FreshConnection.connection_manager = EbisuConnection::ConnectionManager
