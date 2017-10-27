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

    describe 'Video information' do
        it 'HAPPY: should provide correct video id' do
            get "#{API_VER}/videos/#{QUERY_NAME}"
            _(last_response.status).must_equal 200
            video_data = JSON.parse last_response.body
            _(video_data.size).must_be :>, 0
        end

        it 'SAD: should raise exception on incorrect query name' do
            get "#{API_VER}/videos/??"
            _(last_response.status).must_equal 404
            body = JSON.parse last_response.body
            _(body.keys).must_include 'error'
        end
    end
end
