require_relative 'spec_helper.rb'

describe 'Tests Praise library' do
  VCR.configure do |c|
    c.cassette_library_dir = './spec/fixtures/cassettes'
    c.hook_into :webmock
    c.filter_sensitive_data('<API_KEY>') { CONFIG['GOOGLE_API_KEY'] }
    c.filter_sensitive_data('<API_KEY_ESC>') { CGI.escape(CONFIG['GOOGLE_API_KEY']) }
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

    it 'HAPPY: should be video in array' do
      @video_info.each do |x|
        x.must_be_instance_of VideosPraise::VideoData
      end
    end

    it 'HAPPY: should provide same video id' do
      @video_info.zip(CORRECT).each do |v1, v2|
        _(v1.videoId.to_s).must_equal v2.videoId.to_s
      end
    end

    it 'HAPPY: video id should never be nil' do
      @video_info.each do |v1|
        _(v1.videoId.to_s).wont_be_nil
      end
    end
  end
end
