require 'rubygems'
require 'bundler'

Bundler.require(:default)

require_relative 'config/active_support'
require_relative 'config/redis'
require_relative 'config/resque'

require 'resque/tasks'

task :enqueue_high do
  Resque.enqueue(ExampleJob)
end

task :enqueue_low do
  Resque.enqueue(ExampleJob, priority: "low")
end
