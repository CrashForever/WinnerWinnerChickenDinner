module VideosPraise
  # Web API
  class Api < Roda
    plugin :all_verbs
    route('vision') do |routing|
      # #{API_ROOT}/vision/upload
      routing.on 'upload' do
        routing.post do

          file = routing.params['file']

          #puts Api.config.methods
          analyzed_result = ImageAnalyze.new.call(
            config: Api.config,
            file: file
          )

          # http_response = HttpResponseRepresenter
          #                 .new(Result.new(:ok, 'Analyze success'))
          # response.status = http_response.http_code
          # http_response.to_json # if result.success?


          http_response = HttpResponseRepresenter.new(analyzed_result.value)

          response.status = http_response.http_code
          if analyzed_result.success?
            response['Location'] = "/api/v0.1/vision/upload"
            ImageAnalyzedRepresenter.new(analyzed_result.value.message).to_json
          else
            http_response.to_json
          end
        end
      end
      routing.on 'camera_photo' do
        routing.post do
          puts "in camera_photo vision.rb"
          photo = routing.params['img']

          #puts Api.config.methods
          analyzed_result = CameraPhotoAnalyze.new.call(
            config: Api.config,
            photo: photo
          )

          # http_response = HttpResponseRepresenter
          #                 .new(Result.new(:ok, 'Analyze success'))
          # response.status = http_response.http_code
          # http_response.to_json # if result.success?


          http_response = HttpResponseRepresenter.new(analyzed_result.value)

          response.status = http_response.http_code
          if analyzed_result.success?
            response['Location'] = "/api/v0.1/vision/upload"
            ImageAnalyzedRepresenter.new(analyzed_result.value.message).to_json
          else
            http_response.to_json
          end
        end
      end
      routing.on 'oauth2callback' do
        routing.get do
          puts 'hi'
          puts '-------'
          puts routing.params['code']
        end
      end

    end
  end
end
