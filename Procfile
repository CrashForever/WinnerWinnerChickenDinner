web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
worker: bundle exec shoryuken -r ./workers/get_videos_worker.rb -C ./workers/shoryuken.yml
