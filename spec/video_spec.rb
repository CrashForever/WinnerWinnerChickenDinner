require_relative 'spec_helper.rb'

describe 'Tests Praise library' do
  end

  describe 'Body Information' do
    before do
      VCR.insert_cassette CASSTTE_FILE,
                          record: :new_episodes,
                          match_requests_on: [:method, :uri, :headers]


      @video_info = VideosPraise::YoutubeAPI.new(CONFIG).get_video(QUERY_NAME)

    end

    after do
      VCR.eject_cassette
    end

  describe 'Body Information' do
    it 'HAPPY: should be video in array' do
      end
    end

    it 'HAPPY: should provide same video id' do
      @video_info.zip(CORRECT).each do |v1, v2|
      end
    end

    it 'HAPPY: video id should never be nil' do
      @video_info.each do |v1|
      end
    end
  end
end
