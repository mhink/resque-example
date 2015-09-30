ActiveJob::Base.queue_adapter = :resque

ajls = ActiveSupport::LogSubscriber.log_subscribers.find do |ls|
  ls.class == ActiveJob::Logging::LogSubscriber
end

def unsubscribe(component, subscriber)
  events = subscriber.public_methods(false).reject { |method| method.to_s == 'call' }
  events.each do |event|
    ActiveSupport::Notifications.notifier.listeners_for("#{event}.#{component}").each do |listener|
      if listener.instance_variable_get('@delegate') == subscriber
        ActiveSupport::Notifications.unsubscribe listener
      end
    end
  end
end

unsubscribe(:active_job, ajls)
