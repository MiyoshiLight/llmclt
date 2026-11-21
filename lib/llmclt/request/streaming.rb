# frozen_string_literal: true

module Llmclt
  module Request
    class Streaming < Base
      include Llmclt::Request::Chat

      def endpoint_uri
        if @config.api_key_blank?
          URI.parse(
            "https://#{endpoint_host}/v1/projects/#{@config.project_id}/locations/#{@config.location_id}/publishers/google/models/#{@config.model}:streamGenerateContent"
          )
        else
          URI.parse(
            "https://#{endpoint_host}/v1/publishers/google/models/#{@config.model}:streamGenerateContent?key=#{@config.api_key}"
          )
        end
      end

      def build_response(response)
        Llmclt::Response::Streaming.new(response)
      end
    end
  end
end
