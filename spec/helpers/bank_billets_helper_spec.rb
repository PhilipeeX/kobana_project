require 'rails_helper'

RSpec.describe BankBilletsHelper, type: :helper do
  describe '.process_response' do
    context 'when the response status is "generating"' do
      let(:response_body) { { 'status' => 'generating' }.to_json }

      it 'returns success as true' do
        result = described_class.process_response(response_body)
        expect(result[:success]).to be true
      end
    end

    context 'when the response includes errors' do
      let(:response_body) { { 'errors' => { 'field' => ['Error message'] } }.to_json }

      it 'returns success as false and includes error messages' do
        result = described_class.process_response(response_body)
        expect(result[:success]).to be false
        expect(result[:error_messages]).to eq 'field: Error message'
      end
    end

    context 'when the response does not match any condition' do
      let(:response_body) { { 'unknown' => 'value' }.to_json }

      it 'returns success as false and a generic error message' do
        result = described_class.process_response(response_body)
        expect(result[:success]).to be false
        expect(result[:error_messages]).to eq I18n.t('bank_billets_helper.error_message')
      end
    end
  end
end
