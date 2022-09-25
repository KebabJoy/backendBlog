# frozen_string_literal: true

module Ai
  module Assembly
    class BaseService
      BASE_URL = 'https://api.assemblyai.com/v2/transcript'

      protected

      def request_url(endpoint: '')
        BASE_URL + endpoint
      end

      def default_headers
        {
          'authorization' => 'fa5a6c24b1774fd4a2c6ce642ff8141c',
          'content-type'  => 'application/json'
        }
      end
    end
  end
end
