# video_mapper.rb
require 'json'

module VideosPraise
  # Library for FacebookAPI
  module GoogleVision
    # Data Mapper object for Youtube's data
    class GoogleMapper
      def initialize(config, gateway_class = GoogleVision::Api)
         @config = config
         @gateway_class = gateway_class
         @gateway = @gateway_class.new(@config.GOOGLE_API_KEY)
      end

      def load(base64_file_string)
        analyzed_data = @gateway.analyze(base64_file_string)
        # puts "Hi i am back "
        # puts analyzed_data
        build_entity(analyzed_data)
      end

      def build_entity(analyzed_data)
        DataMapper.new(analyzed_data, @config, @gateway_class).build_entity
      end

      class DataMapper
        def initialize(analyzed_data, config, gateway_class)
          @analyzed_data = analyzed_data
        end

        def build_entity
            obj = VideosPraise::Entity::GoogleVision.new(
                # kind: kind,
                # videoId: videoId
                # id: nil,
                label: label,
                score: score
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

        def label
          tmp = JSON.parse(@analyzed_data.to_json)
          label = tmp['responses'][0]['labelAnnotations'][0]['description']
          label
        end
        def score
          tmp = JSON.parse(@analyzed_data.to_json)
          score = tmp['responses'][0]['labelAnnotations'][0]['score']
          score
        end
      end
    end
  end
end
