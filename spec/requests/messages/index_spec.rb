require 'rails_helper'

describe 'Message listing' do
  let!(:sender) { create(:user) }
  let!(:recipient) { create(:user) }
  let!(:token) { user_token(sender) }
  let!(:participant) { create(:participant, sender_id: sender.id, recipient_id: recipient.id) }
  let!(:message_one) { create(:message, id: 1, body: 'Hi', user_id: sender.id, participant_id: participant.id) }
  let!(:message_two) { create(:message, id: 2, body: 'How are you?', user_id: sender.id, participant_id: participant.id) }
  let!(:message_three) { create(:message, id: 3, body: 'I am good.', user_id: participant.id, participant_id: sender.id) }

  context 'Invalid requests' do
    it 'Does not fetch any messages' do
      get messages_path, params: { }, headers: header_params(token: token)
      expect(status).to eq(422)
      expect(JSON.parse(response.body)['error']).to eq("Recipient ID is missing")
    end
  end

  context 'Valid requests with different params' do
    it 'Does fetch all the messages of the sender and recipients, when recipient id is given' do
      get messages_path, params: { recipient_id: recipient.id }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(JSON.parse(response.body)['messages'].count).to eq(3)
      expect(JSON.parse(response.body)['messages'].pluck('id')).to match_array([1,2,3])
    end

    it 'Does fetch all the messages of the sender and recipients and sorts the messages on date, when recipient id and sort filter is given' do
      get messages_path, params: { recipient_id: recipient.id, sort: 'desc' }, headers: header_params(token: token)
      expect(status).to eq(200)
      expect(JSON.parse(response.body)['messages'].count).to eq(3)
      expect(JSON.parse(response.body)['messages'].pluck('id')).to match_array([3,2,1])
    end
  end

end
