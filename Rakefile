require 'rubygems'
require 'bundler'

Bundler.require(:default)

require_relative 'config/active_support'
require_relative 'config/redis'
require_relative 'config/resque'
require_relative 'config/event_machine'

require 'resque/tasks'

def define_jobs(hsh)
  hsh.each do |job, desc|
    job_cls = Class.new do
      @jobname = job
      @delay = desc[:delay]
      @queue = desc[:queue]

      def self.before_enqueue(ttn)
        puts "(#{"%.2f" % ttn.round(2)}) Enqueueing #{@jobname} on '#{@queue}' queue "
      end

      def self.perform(ttn)
        uuid = SecureRandom.hex(4)
        if @delay && @delay > 0
          puts "Performing #{@jobname}@#{uuid}... (#{@delay}s)"
          sleep @delay
          puts "Finished #{@jobname}@#{uuid}"
        else
          puts "Performing #{@jobname}@#{uuid}."
        end
      end
    end
    Object.const_set(job, job_cls)
  end
end

TEST_1 = {
  :SmallJob  => { rate: 1,   delay: 0.5, queue: :low  },
  :MediumJob => { rate: 0.5, delay: 3, queue: :high },
}

define_jobs TEST_1

task :test_1 do
  start_event_machine do
    TEST_1.each do |job, desc|
      PoissonTimer.new(desc[:rate]) do |ttn|
        begin
        Resque.enqueue(Object.const_get(job), ttn)
        rescue => ex
          puts ex
          EventMachine.stop
        end
      end
    end
  end
end

task :resque_monitor do
  connected = false

  begin
    connected = REDIS.info
  rescue => ex
    connected = nil
  end

  if connected
    puts Terminal::Table.new(rows: Resque.info.to_a)

    rows = Resque.queues.map do |queue_name|
      [queue_name, Resque.size(queue_name)]
    end

    puts Terminal::Table.new(rows: rows)
  else
    puts "(not connected to Redis)"
  end
end
