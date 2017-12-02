module VideosPraise
  # Web API
  class Api < Roda
    plugin :all_verbs
    route('vision') do |routing|
      # #{API_ROOT}/vision/upload
      routing.on 'upload' do
        routing.post do
          file = routing.params['file']
          puts file
          # result = GetQueryNameNum.call(query_name: query_name)
          #
          # http_response = HttpResponseRepresenter.new(result.value)
          # response.status = http_response.http_code
          # puts find_all_result.value.message[:query_name]
          # puts find_all_result.value.message[:number]
          http_response = HttpResponseRepresenter
                          .new(Result.new(:ok, 'Analyze success'))
          response.status = http_response.http_code
          http_response.to_json # if result.success?
          #   QueryNumberRepresenter.new(result.value.message).to_json
          # else
          #   http_response.to_json
          # end
        end
      end
    end
  end
end
