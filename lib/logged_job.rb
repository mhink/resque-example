module LoggedJob
  def self.debug(str)
    Resque.logger.debug(str)
  end

  def self.before_enqueue_log_pid(*args)
    debug "Before enqueue, PID #{Process.pid}, #{args}"
  end

  def self.after_enqueue_log_pid(*args)
    debug "After enqueue, PID #{Process.pid}, #{args}"
  end

  def self.before_perform_log_pid(*args)
    debug "Before perform, PID #{Process.pid}, #{args}"
  end

  def self.after_perform
    debug "After perform, PID #{Process.pid}"
  end

  def self.on_failure(ex, args)
    debug "PID #{Process.pid} failed with args #{args}:"
    debug ex
  end
end
