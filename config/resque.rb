Resque.redis = REDIS

Resque.logger.level = Logger::DEBUG

Resque.before_fork do |job|
  Resque.logger.debug "Before fork: PID #{Process.pid}, #{job}"
end

Resque.after_fork do |job|
  Resque.logger.debug "After fork: PID #{Process.pid}, #{job}"
end
