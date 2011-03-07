require 'resque/worker'
require 'timeout'

module Resque::Plugins
  module Timeout
    
    def self.switch
      @switch ||= :on
    end

    def self.switch=(val)
      @switch = val
    end

    def self.timeout
      @timeout ||= 600
    end

    def self.timeout=(val)
      @timeout = val
    end

    def around_perform_with_timeout(*args)
      ::Timeout.timeout(Resque::Plugins::Timeout.timeout) do
        yield
      end
    end

  end
  
  # inject the Timeout mixin into the job class right before it
  # executes (if it's not already there). This will give it the
  # `around_perform_...` method above which wraps the execution
  # in the ::Timeout.timeout block
  Resque.before_fork do |job|
    if Resque::Plugins::Timeout.switch == :on && 
        !(job.payload_class.kind_of?(Resque::Plugins::Timeout))
      job.payload_class.send(:extend, Resque::Plugins::Timeout)
    end
      
  end
end


