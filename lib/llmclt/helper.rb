# frozen_string_literal: true

module Llmclt
  module Helper
    module_function

    def camelize_lower(term)
      term.to_s.gsub(/_([a-z0-9])/i) { Regexp.last_match(1).upcase }
    end

    def camelize_keys(keys, setting)
      return {} if setting.nil? || setting.empty?

      keys.each_with_object({}) do |key, cfg|
        next if setting[key].nil?

        p = camelize_lower(key).to_sym
        cfg[p] = setting[key]
      end
    end
  end
end
