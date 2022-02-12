class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    return missing_recipient unless params[:recipient_id].present?

    all_messages = MessageQuery.new(current_user: current_user, params: params).run
    render json: { messages: all_messages }
  end

  def create
    recipient_id = message_params.dig(:participant_attributes, :recipient_id)
    @participant = participant(recipient_id) || Participant.create!(sender_id: sender_id, recipient_id: recipient_id)
    msg_params = message_params.except(:participant_attributes).merge(:user_id => sender_id)

    render json: { message: 'success' }, status: :ok if @participant.messages.new(msg_params).save

  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def missing_recipient
    render json: { error: 'Recipient ID is missing' }, status: :unprocessable_entity
  end

  def message_params
    params.require(:message).permit(
      :body,
      participant_attributes: %i[recipient_id]
    )
  end

  def sender_id
    @sender_id ||= current_user.id
  end

  def participant(recipient_id)
    @participant = Participant.message_exchange(current_user.id, recipient_id)&.first
  end
end
