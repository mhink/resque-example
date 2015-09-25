module MemoryLimitedJob
  def self.before_perform_limit_memory
    mem_limit = 512 #mb
    puts "Limiting memory usage of PID #{Process.pid} to #{mem_limit} mb."
    Process.setrlimit(Process::RLIMIT_RSS,  1024*1024*mem_limit, Process::RLIM_INFINITY)
    Process.setrlimit(Process::RLIMIT_AS,   1024*1024*mem_limit, Process::RLIM_INFINITY)
    Process.setrlimit(Process::RLIMIT_CORE, 0,                    Process::RLIM_INFINITY)
  end
end
