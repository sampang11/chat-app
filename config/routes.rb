Rails.application.routes.draw do

  scope :api, default: { format: :json } do
    # devise_for :users, controllers: { sessions: :sessions }
    devise_for :users, controllers: {
      sessions: :sessions,
      registrations: :registrations,
    }, default: { format: :json }

    resource :user, only: [:show, :update]
    resources :messages
  end
end
