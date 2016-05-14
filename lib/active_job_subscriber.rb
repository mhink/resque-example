require 'active_support/concern'

module ActiveJob
  module Instrumentation
    extend ActiveSupport::Concern

    included do
      around_enqueue do |job, block|
        block.call
      end
    end

    class Subscriber < ActiveSupport::Subscriber
    end
  end
end
