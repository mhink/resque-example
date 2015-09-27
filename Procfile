worker_high: QUEUE=high     INTERVAL=0.25 TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 bundle exec rake resque:work
worker:      QUEUE=low,high INTERVAL=0.25 TERM_CHILD=1 RESQUE_TERM_TIMEOUT=10 bundle exec rake resque:work
redis:      redis-server --port 6380
