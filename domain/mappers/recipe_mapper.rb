# video_mapper.rb
module VideosPraise
  # Library for FacebookAPI
  module Edamam
    # Data Mapper object for Youtube's data
    class RecipeMapper
      def initialize(config, gateway_class = Edamam::Api)
         @config = config
         @gateway_class = gateway_class
         @gateway = @gateway_class.new(@config.EDAMAM_APP_ID, @config.EDAMAM_APP_KEY)
      end

      def load(query_name)
        recipe_data = @gateway.get_recipe(query_name)
        build_entity(recipe_data, query_name)
      end

      def build_entity(recipe_data, query_name)
        DataMapper.new(recipe_data, @config, @gateway_class, query_name).build_entity
      end

      class DataMapper
        def initialize(recipe_data, config, gateway_class, query_name)
          @recipe_data = recipe_data
          @query_name = query_name
        end

        def build_entity
            obj = VideosPraise::Entity::Recipe.new(
                query_name: @query_name,
                label: label,
                image: image,
                url: url
            )
            return obj
        end

        def label
          label_ary = []
          @recipe_data['hits'].each do |recipes|
            label_ary << recipes['recipe']['label']
          end
          label_ary
        end

        def image
          image_ary = []
          @recipe_data['hits'].each do |recipes|
            image_ary << recipes['recipe']['image']
          end
          image_ary
        end

        def url
          url_ary = []
          @recipe_data['hits'].each do |recipes|
            url_ary << recipes['recipe']['url']
          end
          url_ary
        end

      end
    end
  end
end
