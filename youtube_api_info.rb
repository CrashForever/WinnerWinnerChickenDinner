require 'http'
require 'yaml'
require 'json'
require_relative './lib/youtube_api.rb'

config = YAML::load(File.read('./config/secrets.yml'))
#https://graph.facebook.com/v2.10/576472312465910_1462879673825165?fields=id,likes{name,link},message,expanded_height,created_time,with_tags&access_token=132884690698758|dQjGqLbXdJtjOeX8tB55nVHLfSw
YouTubeAPIclient = VideosPraise::YoutubeAPI.new(config)
Video_results = YouTubeAPIclient.get_video('tomato recipe')

File.write('./spec/fixtures/results.yml', Video_results.to_yaml)
