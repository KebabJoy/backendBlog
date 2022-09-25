# frozen_string_literal: true

module Ai
  module Deepgram
    class SpeechToText < BaseService
      include Dry::Monads::Result::Mixin
      extend Dry::Initializer

      option :audio_url, required: true

      def call
        response = HttpClient.new(
          url: request_url,
          body: payload,
          headers: default_headers,
          method: :post
        ).call

        return Success(parsed_response(response)) if response&.success?

        response
      end

      private

      def payload
        {
          url: audio_url,
        }
      end

      def parsed_response(response)
        response.success.dig(:results, :channels, 0, :alternatives, 0, :transcript)
      end
    end
  end
end
