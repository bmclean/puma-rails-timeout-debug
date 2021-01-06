Rack::Timeout.register_state_change_observer(:slow_requests) do |env|
  puts "\e[36mPuma request body wait time (ms): #{env["puma.request_body_wait"]}\e[0m"
  if env[Rack::Timeout::ENV_INFO_KEY].state == :timed_out
    puts "****************** Rack::Timeout state is timed out!!!!! ******************"
  elsif env[Rack::Timeout::ENV_INFO_KEY].state == :expired
    puts "****************** Rack::Timeout state is expired!!!!! ******************"
  end
end
