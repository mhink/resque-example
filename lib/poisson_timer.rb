class PoissonTimer
  attr_accessor :rate
  attr_reader :count

  def initialize(rate, callback=nil, &block)
    @rate = rate
    @code = callback || block
    @cancelled = false
    @ttn = 0
    @count = 0
    schedule
  end

  def cancel
    @cancelled = true
  end

  def schedule
    EventMachine.add_timer @ttn, method(:fire)
    @ttn = time_till_next
  end

  def fire
    unless @cancelled
      @code.call(@ttn, @count)
      @count += 1
      schedule
    end
  end

  private
  def time_till_next
    -Math.log(1.0 - Random.rand) / @rate
  end
end
