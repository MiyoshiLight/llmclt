# frozen_string_literal: true

module Llmclt
  class Config
    class SafetyConfig
      # SafetySettings parameters
      # category: enum
      # HARM_CATEGORY_SEXUALLY_EXPLICIT
      # HARM_CATEGORY_HATE_SPEECH
      # HARM_CATEGORY_HARASSMENT
      # HARM_CATEGORY_DANGEROUS_CONTENT
      # threshold: enum
      # OFF
      # BLOCK_NONE
      # BLOCK_LOW_AND_ABOVE
      # BLOCK_MEDIUM_AND_ABOVE
      # BLOCK_ONLY_HIGH

      PARAMETERS = %i[category threshold].freeze

      def initialize(settings = [])
        @settings = settings
      end

      def build_request_content
        return {} if @settings.nil? || @settings.empty?

        {
          safetySettings: @settings.map { |setting| Llmclt::Helper.camelize_keys(PARAMETERS, setting) }
        }
      end
    end
  end
end
