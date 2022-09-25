# frozen_string_literal: true

module Ai
  module Deepgram
    class BaseService
      BASE_URL = 'https://api.deepgram.com/v1/listen?punctuate=true'

      protected

      def request_url(endpoint: '')
        BASE_URL + endpoint
      end

      def default_headers
        {
          'authorization' => 'token b5161ff157c6e9939a4c1c003a938b3a29fb7ab9',
          'content-type'  => 'application/json'
        }
      end
    end
  end
end
