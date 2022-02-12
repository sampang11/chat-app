class MessageQuery
  attr_accessor(
    :current_user,
    :params,
    :participant
  )

  def initialize(current_user:, params:)
    @current_user = current_user
    @params = params
    @participant = Participant.message_exchange(current_user.id, params[:recipient_id]).first
  end

  def run
    update_seen_status(preload_messages)
    params[:sort].present? ? preload_messages.sort_by_date(params[:sort]) : preload_messages
  end

  private

  def preload_messages
    per_page = 10 # this value can be changed as per the requirement
    page = params[:page] || 1
    participant.messages.page(page).per(per_page)
  end

  def update_seen_status(messages)
    if messages.last.user_id != current_user.id
      Message.update_all(seen: true)
    end
  end
end
