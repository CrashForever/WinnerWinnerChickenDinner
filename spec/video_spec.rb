require_relative 'spec_helper.rb'

describe 'Tests Praise library' do

  CASSTTE_FILE = 'youtube_api'.freeze

  before do
    VCR.insert_cassette CASSTTE_FILE,
                        record: :new_episodes,
                        match_requests_on: [:method, :uri, :headers]
    # @video_info = VideosPraise::YoutubeAPI.new(CONFIG).get_video(QUERY_NAME)
  end

  after do
    VCR.eject_cassette
  end

  describe 'Body Information' do
    # it 'HAPPY: should be video in array' do
    #   @video_info.each do |video|
    #     video.must_be_instance_of VideosPraise::VideoData
    #   end
    # end

    it 'HAPPY: should provide same video id' do
    #   @video_info.zip(CORRECT).each do |v1, v2|
    #     v1.videoId.must_equal v2.videoId
    #   end
    end

    it 'HAPPY: video id should never be nil' do
    #   @video_info.each do |v1|
    #     v1.videoId.wont_be_nil
    #   end
    end
  end
end
