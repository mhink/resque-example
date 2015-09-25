class ExampleJob
  include LoggedJob

  @queue = :high

  def self.perform
    puts "Performing #{self.inspect}..."
    sleep 1
    puts "Finished #{self.inspect}."
  end
end
