def start_event_machine(&block)
  puts "Initializing EventMachine on PID #{Process.pid}, #{Thread.current}"
  EventMachine.run do
    Signal.trap("INT")  { puts "Stopping... (INT)";  EventMachine.stop }
    Signal.trap("TERM") { puts "Stopping... (TERM)"; EventMachine.stop }
    yield
  end
end
