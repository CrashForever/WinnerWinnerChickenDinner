require_relative 'spec_helper.rb'

describe 'Tests Praise library' do
    API_VER = 'api/v0.1'.freeze
    CASSTTE_FILE = 'videopraise_api'.freeze

    before do
      VCR.insert_cassette CASSTTE_FILE,
                          record: :new_episodes,
                          match_requests_on: [:method, :uri, :headers]
    end

    after do
        VCR.eject_cassette
    end

    describe 'Is Api working' do
        it 'HAPPY: It works!' do
            get "/"
            _(last_response.status).must_equal 200
        end
    end

    describe 'Video information' do
        it 'HAPPY: should provide correct video id' do
            get "#{API_VER}/videosearch/#{QUERY_NAME}"
            _(last_response.status).must_equal 200
            video_data = JSON.parse last_response.body
            _(video_data.size).must_be :>, 0
        end

        it 'HAPPY: should provide correct video kinds' do
            get "#{API_VER}/videosearch/#{QUERY_NAME}/kinds"
            _(last_response.status).must_equal 200
            video_data = JSON.parse last_response.body
            _(video_data.size).must_be :>, 0
        end

        it 'SAD: should raise exception on incorrect query name' do
            get "#{API_VER}/videosearch/wrong"
            _(last_response.status).must_equal 404
        end
    end
end
