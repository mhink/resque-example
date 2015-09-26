require 'rubygems'
require 'bundler'

Bundler.require(:default)

require_relative 'config/active_support'
require_relative 'config/redis'
require_relative 'config/resque'
require_relative 'config/event_machine'

require 'resque/tasks'

task :poisson do
  start_event_machine do
    PoissonTimer.new(0.5) do |ttn, count|
      Resque.enqueue(ExampleJob, priority: "low")
    end
  end
end

task :enqueue_low do
  Resque.enqueue(ExampleJob, priority: "low")
end
