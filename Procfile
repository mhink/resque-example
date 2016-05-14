worker_high: QUEUE=high,low INTERVAL=0.25 TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 bundle exec rake resque:work
worker_med:  QUEUE=high,low INTERVAL=0.25 TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 bundle exec rake resque:work
worker_low:  QUEUE=low,high INTERVAL=0.25 TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 bundle exec rake resque:work
worker_low2:  QUEUE=low,high INTERVAL=0.25 TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 bundle exec rake resque:work
redis:      redis-server --port 6380
