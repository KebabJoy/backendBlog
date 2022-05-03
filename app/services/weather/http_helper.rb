# frozen_string_literal: true

module Weather
  class HttpHelper
    class HttpError < StandardError; end

    BASE_URL = 'http://dataservice.accuweather.com'

    def initialize(endpoint:, params: {})
      @endpoint = endpoint
      @params = params.merge(apikey: ENV['WEATHER_API_KEY'])
    end

    def get
      response = connection.get(@endpoint + @params.to_query)
      raise HttpError, 'Something went wrong processing your request' unless response.status == 200

      response.body
    end

    private

    def connection
      Faraday.new(BASE_URL) do |conn|
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
