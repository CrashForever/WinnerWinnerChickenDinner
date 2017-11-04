require 'http'
require 'yaml'
require 'json'
require_relative './infrastructure/youtube/youtube_api.rb'
require_relative './domain/mappers/video_mapper.rb'

config = YAML::load(File.read('./config/secrets.yml'))['GOOGLE_API_KEY']
#https://graph.facebook.com/v2.10/576472312465910_1462879673825165?fields=id,likes{name,link},message,expanded_height,created_time,with_tags&access_token=132884690698758|dQjGqLbXdJtjOeX8tB55nVHLfSw
YouTubeAPI = VideosPraise::Youtube::API.new(config)
Video_mapper = VideosPraise::Youtube::VideoMapper.new(YouTubeAPI)
res = Video_mapper.load('tomato recipe')
puts res
res.each do |x|
  puts x.videoId
  puts '======='
  puts x.kind
end
#File.write('./spec/fixtures/results.yml', Video_results.to_yaml)
