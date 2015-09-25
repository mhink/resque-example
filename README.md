# Redis Testbed Project
The purpose of this repo is to demonstrate how varying amounts of work affect the throughput of Resque workers.

## Installation and Running
Currently, this uses Redis, so you'll need to have it installed on your system.

Just `bundle install` to get the gem dependencies, and then do `foreman start` to spin up Redis and the Resque workers.

To put work in the queue, use `bundle exec rake enqueue_high` (or create your own Rake tasks.)

## Working with the code
Code in /jobs and /lib is autoloaded, no `require` needed. /jobs are Resque jobs, /lib is everything else.

Config goes in /config, and should be explicitly required at the top of the Rakefile.

There's not really enough tasks yet to have a separate folder for them- the Rakefile itself is fine for now.
