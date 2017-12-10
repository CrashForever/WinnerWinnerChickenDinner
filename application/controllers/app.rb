require 'roda'

module VideosPraise
  # Web API
  class Api < Roda
    plugin :halt
    plugin :all_verbs
    plugin :multi_route

    require_relative 'video'
    require_relative 'vision'
    require_relative 'recipe'

    route do |routing|
      response['Content-Type'] = 'application/json'

      # GET / request
      routing.root do
        { 'message' => "CodePraise API v0.1 up in #{Api.environment} mode" }
        HttpResponseRepresenter.new(Result.new(:ok, message)).to_json
      end

      routing.on 'api' do
        # /api/v0.1 branch
        routing.on 'v0.1' do
          @api_root = '/api/v0.1'
          routing.multi_route
        end
      end
    end
  end
end
