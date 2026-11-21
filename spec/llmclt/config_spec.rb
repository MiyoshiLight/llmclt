# frozen_string_literal: true

RSpec.describe Llmclt::Config do
  describe '#initialize' do
    it 'initializes a instance' do
      config = described_class.new(system_instruction_prompt: "I'm a helpful assistant.")
      expect(config.system_instruction_prompt).to eq("I'm a helpful assistant.")
    end
  end

  describe '#api_key? and #api_key_blank?' do
    context 'when api_key is present' do
      let(:config) { described_class.new(api_key: 'test_key') }

      it 'returns true for api_key? and false for api_key_blank?' do
        expect(config.api_key?).to be(true)
        expect(config.api_key_blank?).to be(false)
      end
    end

    context 'when api_key is nil or empty' do
      it 'returns false for api_key? when nil' do
        config = described_class.new(api_key: nil)
        expect(config.api_key?).to be(false)
        expect(config.api_key_blank?).to be(true)
      end

      it 'returns false for api_key? when empty string' do
        config = described_class.new(api_key: '   ')
        expect(config.api_key?).to be(false)
        expect(config.api_key_blank?).to be(true)
      end
    end
  end
end
