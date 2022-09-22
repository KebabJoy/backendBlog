# frozen_string_literal: true

module Ai
  class HttpClient
    extend Dry::Initializer
    include Dry::Monads::Result::Mixin

    option :url, required: true
    option :body, default: ->{ {} }
    option :headers, required: true
    option :method, required: true

    def call
      response = connection.send(method.to_sym) do |req|
        req.headers = headers
        req.body = body.to_json
      end

      return Failure(parsed_body(response)) if (200..299).exclude? response.status

      Success(parsed_body(response))
    rescue => e
      pp e
    end

    private

    # TODO: разобраться с Тифеем
    # Ебучий Тифей не работает, пришлось юзать эту залупу
    # objc[6554]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called.
    # objc[6554]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called. We cannot safely call it or ignore it in the fork() child process. Crashing instead. Set a breakpoint on objc_initializeAfterForkError to debug.
    def connection
      Faraday.new(url: url, params: body, headers: headers) do |conn|
        conn.adapter Faraday.default_adapter
      end
    end

    def parsed_body(response)
      return {} if response.body.blank?

      JSON.parse(response.body).deep_symbolize_keys!
    end
  end
end
