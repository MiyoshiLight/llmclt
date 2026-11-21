# frozen_string_literal: true

RSpec.describe Llmclt::Helper do
  describe '.camelize_lower' do
    it 'converts snake_case symbols to lowerCamelCase strings' do
      expect(described_class.camelize_lower(:candidate_count)).to eq('candidateCount')
      expect(described_class.camelize_lower(:top_p)).to eq('topP')
    end

    it 'handles strings and single words' do
      expect(described_class.camelize_lower('audio_timestamp')).to eq('audioTimestamp')
      expect(described_class.camelize_lower(:temperature)).to eq('temperature')
    end
  end

  describe '.camelize_keys' do
    it 'camelizes specified keys present in hash' do
      keys = %i[temperature top_p not_exist]
      setting = { temperature: 0.7, top_p: 0.9, ignored: true }
      result = described_class.camelize_keys(keys, setting)

      expect(result).to eq({ temperature: 0.7, topP: 0.9 })
    end

    it 'returns empty hash when setting is nil or empty' do
      expect(described_class.camelize_keys([:foo], nil)).to eq({})
      expect(described_class.camelize_keys([:foo], {})).to eq({})
    end
  end
end
