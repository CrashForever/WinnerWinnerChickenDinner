# video_mapper.rb
require_relative './entities/init.rb'
module VideosPraise
  # Library for FacebookAPI
  module Youtube
    # Data Mapper object for Youtube's data
    class VideoMapper
      def initialize(gateway)
        @gateway = gateway
      end

      def load(query_name)
        video_data = @gateway.get_video(query_name)
        build_entity(video_data)
      end

      def build_entity(video_data)
        DataMapper.new(video_data, @gateway).build_entity
      end
      class DataMapper
        def initialize(video_data, gateway)
          @video_data = video_data

        end

        def build_entity
          response_entity = []
          #@video_data['items'].each do |item|
            response_entity << VideosPraise::Entity::VideoContent.new(
                kind: kind,
                videoId: videoId
            )
          #end

        end

        def kind
          kind_ary = []
          @video_data['items'].each do |item|
            kind_ary << item['id']['kind']
          end
          # @video_data['items']['id']['kind']
          kind_ary
        end

        def videoId
          #@video_data['items']['id']['videoId']
          videoId_ary = []
          @video_data['items'].each do |item|
            videoId_ary << item['id']['videoId']
          end
          # @video_data['items']['id']['kind']
          videoId_ary
        end

      end
    end
  end
end
