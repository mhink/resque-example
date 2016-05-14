require 'rubygems'
require 'bundler'

Bundler.require(:default)

require_relative 'config/active_support'
require_relative 'config/redis'
require_relative 'config/resque'
require_relative 'config/event_machine'
require_relative 'config/active_job'

require 'resque/tasks'
require 'resque/pool/tasks'

namespace :resque do
  task :setup do
    puts "resque:setup"
  end

  namespace :pool do
    task :setup do
      require 'resque-pool'
      puts "resque:pool:setup"
    end
  end
end

TEST_1 = {
  :SmallJob  => { rate: 0.5, delay: 1, queue: :low  },
}

JobDefiner.define_jobs TEST_1

module ExceptionHandling
  extend ActiveSupport::Concern
  include ActiveSupport::Callbacks

  included do
    define_callbacks :failure
    rescue_from Exception, with: :rescue_from_method 
  end

  def rescue_from_method(err)
    run_callbacks(:failure) do
      puts "ExceptionHandling rescue_from block"
    end
  end

  module ClassMethods
    def on_failure(*filters, &blk)
      set_callback(:failure, :before, *filters, &blk)
    end
  end
end

class ExceptionJob < ActiveJob::Base
  include ExceptionHandling

  queue_as :low

  on_failure :rescue_from_job_method

  def rescue_from_job_method
    puts "ExceptionJob on_failure block"
  end

  def perform
    puts "running..."
    raise StandardError, "ohno!"
  end
end

task :run_error_test do
  ExceptionJob.perform_later
end

class ResqueActiveJob < ActiveJob::Base
  queue_as :low

  before_perform do |job|
    puts "(before) #{self.class.name}@#{job.job_id}..."
  end

  after_perform do |job|
    puts "(after) #{self.class.name}@#{job.job_id}."
  end

  around_perform do |job, block|
    puts "(around-pre) #{self.class.name}@#{job.job_id}."
    block.call
    puts "(around-post) #{self.class.name}@#{job.job_id}."
  end

  rescue_from(StandardError) do |ex|
    puts "Rescued #{ex.inspect}."
    puts "Failed #{self.class.name}@#{job.job_id}."
  end

  def perform(should_raise: false)
    if should_raise
      raise "foo all the bars!"
    else
      puts "Not fooing all the bars."
    end
  end
end

task :enqueue do
  ResqueActiveJob.perform_later(should_raise: true)
  sleep 1
  ResqueActiveJob.perform_later(should_raise: false)
end

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

task :console do
  binding.pry
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
