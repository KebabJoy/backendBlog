# frozen_string_literal: true

module Ai
  class SpeechToText < BaseService
    include Dry::Monads::Result::Mixin
    extend Dry::Initializer

    option :audio_url, required: true

    def call
      enqueue_response = HttpClient.new(
        url: request_url,
        body: enqueue_payload,
        headers: default_headers,
        method: :post
      ).call

      if enqueue_response.success?
        response = HttpClient.new(
          url: request_url(endpoint: endpoint(enqueue_response.success)),
          headers: default_headers,
          method: :get
        ).call

        retry_count = 1

        while response.failure? && retry_count <= 5
          response = HttpClient.new(
            url: request_url(endpoint: endpoint(enqueue_response.success)),
            headers: default_headers,
            method: :get
          ).call
        end
      end

      return Success(parsed_response(response)) if response&.success?

      enqueue_response
    end

    private

    def enqueue_payload
      {
        audio_url: audio_url,
        filter_profanity: true
      }
    end

    def endpoint(response)
      '/' + response[:id].to_s + '/paragraphs'
    end

    def parsed_response(response)
      return unless response

      response.success[:paragraphs].map { |paragraph| paragraph[:text] }.join("\n")
    end
  end
end
