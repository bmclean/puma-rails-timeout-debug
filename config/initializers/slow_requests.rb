Rack::Timeout.register_state_change_observer(:slowpoke) do |env|
  if env[Rack::Timeout::ENV_INFO_KEY].state == :timed_out
    puts "****************** timed out!!!!! ******************"
  elsif env[Rack::Timeout::ENV_INFO_KEY].state == :expired
    puts "****************** expired!!!!! ******************"
  end
end
