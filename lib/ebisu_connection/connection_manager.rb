require 'yaml'
require 'fresh_connection/abstract_connection_manager'

module EbisuConnection
  class ConnectionManager < FreshConnection::AbstractConnectionManager
    class << self
      delegate :slaves_file, :slaves_file=, :check_interval, :check_interval=,
        :slave_type, :slave_type=, :to => EbisuConnection::ConfFile

      delegate :ignore_models=, :to => FreshConnection::SlaveConnection
    end

    delegate :if_modify, :conf_clear!, :slaves_conf, :spec,
      :to => EbisuConnection::ConfFile

    def initialize
      super
      @slaves = {}
    end

    def slave_connection
      slaves.sample.connection
    end

    def put_aside!
      return if check_own_connection

      if_modify do
        reserve_release_all_connection
        check_own_connection
      end
    end

    def recovery(failure_connection, exception)
      if recoverable? && slave_down_message?(exception.message)
        slaves.remove_connection(failure_connection)
        true
      else
        false
      end
    end

    def recoverable?
      true
    end

    def clear_all_connection!
      synchronize do
        @slaves.values.each do |s|
          s.all_disconnect!
        end

        @slaves = {}
        conf_clear!
      end
    end

    private

    def check_own_connection
      synchronize do
        s = @slaves[current_thread_id]

        if s && s.reserved_release?
          s.all_disconnect!
          @slaves.delete(current_thread_id)
          true
        else
          false
        end
      end
    end

    def reserve_release_all_connection
      synchronize do
        @slaves.values.each do |s|
          s.reserve_release_connection!
        end
        conf_clear!
      end
    end

    def slaves
      synchronize do
        @slaves[current_thread_id] ||= get_slaves
      end
    end

    def get_slaves
      EbisuConnection::Slaves.new(slaves_conf, spec)
    end
  end
end
