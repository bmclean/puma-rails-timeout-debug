### Puma 5.0.3+ Slow Client Debug

Also see https://github.com/bmclean/puma-rack-timeout-debug.

This is a very stripped down Rails API. It doesn't support views, mailers, etc.

Using Puma, Rails 6.0 and Faraday.

Start the server:

    RACK_TIMEOUT_SERVICE_TIMEOUT=15 RACK_TIMEOUT_WAIT_TIMEOUT=30 RACK_TIMEOUT_WAIT_OVERTIME=60 rails s

    ruby post.rb

Response:

    Payload size: 630000
    200
    Got it!
    Duration 0.02 seconds

##### Service timeout example:

When "service timeout" is set to 1 second, but the request will sleep for 2 seconds then the request will time out and an error will be raised.

Start the server:

    EXAMPLE_SLEEP_TIME=2 RACK_TIMEOUT_SERVICE_TIMEOUT=1 RACK_TIMEOUT_WAIT_TIMEOUT=30 RACK_TIMEOUT_WAIT_OVERTIME=60 rails s

    ruby post.rb

As expected, this times out:

    Payload size: 630000
    500
    Internal Server Error
    Duration 1.04 seconds

    Rack::Timeout::RequestTimeoutException (Request waited 15ms, then ran for longer than 1000ms )

    env[Rack::Timeout::ENV_INFO_KEY].state == :timed_out

##### Wait timeout example:

    EXAMPLE_SLEEP_TIME=3 RACK_TIMEOUT_SERVICE_TIMEOUT=15 RACK_TIMEOUT_WAIT_TIMEOUT=1 RACK_TIMEOUT_WAIT_OVERTIME=1 rails s

    ruby post.rb

As expected, this times out:

    Payload size: 630000
    500
    Internal Server Error
    Duration 2.03 seconds

    Rack::Timeout::RequestTimeoutException (Request waited 21ms, then ran for longer than 1979ms )

    env[Rack::Timeout::ENV_INFO_KEY].state == :timed_out

##### Wait timeout with link conditioner examples:

    Throttle lets you simulate slow network connections on Linux and Mac OS X:   

    npm install @sitespeed.io/throttle -g

Start the network throttle:

    throttle --profile 3gslow --localhost

Throttle will use sudo so your user will need sudo rights.

    RACK_TIMEOUT_SERVICE_TIMEOUT=1 RACK_TIMEOUT_WAIT_TIMEOUT=3 RACK_TIMEOUT_WAIT_OVERTIME=5 rails s

    ruby post.rb

We have 3 seconds of wait_time plus 5 seconds of wait_overtime.
This request (using the 3gslow throttle) exceeds 8 seconds, so we see:

    Payload size: 630000
    500
    Internal Server Error
    Duration 19.31 seconds

    #<Rack::Timeout::RequestExpiryError: Request older than 8000ms.>

    env[Rack::Timeout::ENV_INFO_KEY].state == :expired

Setting RACK_TIMEOUT_WAIT_OVERTIME=25 allows the payload to be fully received:

    RACK_TIMEOUT_SERVICE_TIMEOUT=1 RACK_TIMEOUT_WAIT_TIMEOUT=3 RACK_TIMEOUT_WAIT_OVERTIME=25 rails s

    Payload size: 630000
    200
    Got it!
    Duration 19.66 seconds

    source=rack-timeout wait=17811ms timeout=1000ms service=58ms state=completed

###### !! Remember to stop the network throttle !!

    throttle --stop --localhost