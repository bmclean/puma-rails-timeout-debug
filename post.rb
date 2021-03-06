require "faraday"
require "json"

payload = ""
7500.times do
  payload += "g5555555aaMCCCCCCEBRBCCCCCIA/QQQQ777sWWWWWssH2lFFFFFYWQ1VVVVV2hhhhGUgaGSDSSSSSRSJBBg"
end

puts "Payload size: #{payload.size}"

connection = Faraday.new
headers = {"X-Request-Start" => "t=#{Time.now.to_f.round(3)}",
           "Content-Type" => "application/json"}
start_time = Time.now.utc
response = connection.post("http://localhost:3000/demo") { |request|
  request.headers = headers
  request.body = {data: payload}.to_json
}

puts response.status
if response.status == 200
  puts response.body
else
  puts "\e[33m#{response.reason_phrase}\e[0m"
end
puts "Duration #{(Time.now.utc - start_time).round(2)} seconds"
