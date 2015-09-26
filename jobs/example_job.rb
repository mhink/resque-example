class ExampleJob
  include LoggedJob

  @queue = :high

  def self.perform
    puts "Performing #{self.inspect}..."
  end
end
