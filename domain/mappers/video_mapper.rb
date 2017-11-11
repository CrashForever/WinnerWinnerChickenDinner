# video_mapper.rb
module VideosPraise
  # Library for FacebookAPI
  module Youtube
    # Data Mapper object for Youtube's data
    class VideoMapper
      def initialize(config, gateway_class = Youtube::Api)
         @config = config
         @gateway_class = gateway_class
         @gateway = @gateway_class.new(@config.GOOGLE_API_KEY)
      end

      def load(query_name)
        video_data = @gateway.get_video(query_name)
        build_entity(video_data, query_name)
      end

      def build_entity(video_data, query_name)
        DataMapper.new(video_data, @config, @gateway_class, query_name).build_entity
      end

      class DataMapper
        def initialize(video_data, config, gateway_class, query_name)
          @video_data = video_data
          @query_name = query_name
        end

        def build_entity
            obj = VideosPraise::Entity::QueryName.new(
                # kind: kind,
                # videoId: videoId
                # id: nil,
                query_name: @query_name,
                video_id: videoId
            )
            return obj
        end

        # def kind
        #   kind_ary = []
        #   @video_data['items'].each do |item|
        #     kind_ary << item['id']['kind']
        #   end
        #   # @video_data['items']['id']['kind']
        #   kind_ary
        # end

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
