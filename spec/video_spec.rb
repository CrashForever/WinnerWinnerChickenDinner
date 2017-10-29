require_relative 'spec_helper.rb'

describe 'Tests Praise library' do
  extend Econfig::Shortcut
  Econfig.env = 'development'
  Econfig.root = '.'

  CASSTTE_FILE = 'youtube_api'.freeze
  API_KEY = config.GOOGLE_API_KEY

  before do
    VCR.insert_cassette CASSTTE_FILE,
                        record: :new_episodes,
                        match_requests_on: [:method, :uri, :headers]

    api = VideosPraise::Youtube::Api.new(API_KEY)
    video_mapper = VideosPraise::Youtube::VideoMapper.new(api)
    @video_info = video_mapper.load(QUERY_NAME)
  end

  after do
    VCR.eject_cassette
  end

  describe 'Body Information' do
    it 'HAPPY: should be video in array' do
      @video_info.must_be_instance_of VideosPraise::Entity::VideoContent
    end

    it 'HAPPY: should provide same video id' do
      _@video_info.videoId.zip(CORRECT).each do |v1, v2|
        v1.must_equal v2.videoId
      end
    end

    it 'HAPPY: video id should never be nil' do
      _@video_info.videoId.each do |v1|
        v1.wont_be_nil
      end
    end
  end
end
