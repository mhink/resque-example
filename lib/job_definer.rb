module JobDefiner
  def self.define_jobs(hsh)
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
end
