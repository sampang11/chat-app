require 'rails_helper'

describe 'Message creation' do
  let!(:sender) { create(:user) }
  let!(:recipient) { create(:user) }
  let!(:token) { user_token(sender) }

  context 'Valid requests' do
    it 'Does fetch all the messages of the sender and recipients, when recipient id is given' do
      post messages_path, params: { message: { body: 'Hello!', participant_attributes: { recipient_id: recipient.id } } }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(Message.count).to eq(1)
      expect(JSON.parse(response.body)['message']).to eq('success')
    end
  end

  context 'Invalid requests' do
    it 'when recipient_id is not provided' do
      post messages_path, params: { message: { body: 'Hello!' } }, headers: header_params(token: token)
      expect(status).to eq(422)
      expect(Message.count).to eq(0)
      expect(JSON.parse(response.body)['error']).to eq('Validation failed: Recipient must exist')
    end
  end

end
