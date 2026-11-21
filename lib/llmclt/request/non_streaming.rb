# frozen_string_literal: true

module Llmclt
  module Request
    class NonStreaming < Base
      include Llmclt::Request::Chat

      def endpoint_uri
        if @config.api_key_blank?
          URI.parse(
            "https://#{endpoint_host}/v1/projects/#{@config.project_id}/locations/#{@config.location_id}/publishers/google/models/#{@config.model}:generateContent"
          )
        else
          URI.parse(
            "https://#{endpoint_host}/v1/publishers/google/models/#{@config.model}:generateContent?key=#{@config.api_key}"
          )
        end
      end

      def build_response(response)
        Llmclt::Response::NonStreaming.new(response)
      end
    end
  end
end
