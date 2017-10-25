require 'http'
require 'yaml'

config = YAML.safe_load(File.read('../config/secrets.yml'))

def youtube_api_path(q)
  'https://www.googleapis.com/youtube/v3/search?part=id&&type=video' + "q=#{q}"
end

def call_youtube_url(config, url)
  HTTP.headers('Accept' => 'application/json').get(url + "&key=#{config['YOUTUBE_API_TOKEN']}")
end

youtube_response = {}
youtube_results = {}

youtube_response['res'] = call_youtube_url(config, youtube_api_path('tomato'))
res = youtube_response['res'].parse

youtube_results['kind'] = res['kind']
youtube_results['etag'] = res['etag']
youtube_results['nextPageToken'] = res['nextPageToken']
youtube_results['regionCode'] = res['regionCode']
youtube_results['pageInfo'] = res['pageInfo']
youtube_results['items'] = res['items']

File.write('../spec/fixtures/youtube_response.yml', youtube_response.to_yaml)
File.write('../spec/fixtures/youtube_results.yml', youtube_results.to_yaml)
