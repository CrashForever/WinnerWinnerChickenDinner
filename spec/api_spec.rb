require_relative 'spec_helper.rb'

describe 'Tests Praise library' do
    API_VER = 'api/v0.1'.freeze
    CASSTTE_FILE = 'videopraise_api'.freeze

    before do
      VCR.insert_cassette CASSTTE_FILE,
                          record: :new_episodes,
                          match_requests_on: [:method, :uri, :headers]
      # DatabaseCleaner.clean
      Rake::Task['db:reset'].invoke
    end

    after do
        VCR.eject_cassette
    end

    describe 'Is API working' do
        it 'HAPPY: It works!' do
            get "/"
            _(last_response.status).must_equal 200
        end
    end

    describe "POSTting to create video from Youtube" do
      it 'HAPPY: should retrieve and store repo and collaborators' do
        post "#{API_VER}/videosearch/#{QUERY_NAME}"
        _(last_response.status).must_equal 201
        repo_data = JSON.parse last_response.body
        _(repo_data.size).must_be :>, 0
      end

      it 'SAD: should report error if wrong query' do
        post "#{API_VER}/videosearch/??"
        _(last_response.status).must_equal 404
      end
    end

    describe "GETing database entities" do
      before do
        post "#{API_VER}/videosearch/#{QUERY_NAME}"
      end

      it 'HAPPY: should find stored video id' do
        get "#{API_VER}/videosearch/#{QUERY_NAME}"
        _(last_response.status).must_equal 200
        repo_data = JSON.parse last_response.body
        _(repo_data.size).must_be :>, 0
      end

      it 'SAD: should report error if no database repo entity found' do
        get "#{API_VER}/videosearch/??"
        _(last_response.status).must_equal 404
      end
    end
end
