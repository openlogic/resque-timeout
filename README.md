resque-timeout
====

Resque plugin to allow long-running jobs to timeout (and fail) automatically.

To install:

    $ gem install resque-timeout

Require the lib in your resque worker:

    require 'resque-timeout'

To set the timeout (in seconds, default is 600):

    Resque::Plugins::Timeout.timeout = 60

To turn it off (it is on by default):

    Resque::Plugins::Timeout.switch = :off

Copyright
-----

Copyright (c) 2011  OpenLogic, Inc. See LICENSE for details.
