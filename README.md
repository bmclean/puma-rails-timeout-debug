### Puma 5.0.3+ Slow Client Debug

This is a very stripped down Rails API. It doesn't support views, mailers, etc.

Using Puma, Rails 6.0 and Faraday.

Start the server:

    RACK_TIMEOUT_SERVICE_TIMEOUT=15 RACK_TIMEOUT_WAIT_TIMEOUT=30 RACK_TIMEOUT_WAIT_OVERTIME=60 rails s

    ruby post.rb

Response:

    Payload size: 630000
    200
    Got it!

##### Service timeout example:

When "service timeout" is set to 1 second, but the request will sleep for 2 seconds then the request will time out and an error will be raised.

Start the server:

    EXAMPLE_SLEEP_TIME=2 RACK_TIMEOUT_SERVICE_TIMEOUT=1 RACK_TIMEOUT_WAIT_TIMEOUT=30 RACK_TIMEOUT_WAIT_OVERTIME=60 rails s

    ruby post.rb

Response:

    Payload size: 630000
    500
    Internal Server Error

    Rack::Timeout::RequestTimeoutException (Request waited 15ms, then ran for longer than 1000ms )
    