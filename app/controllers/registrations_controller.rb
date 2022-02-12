class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(sign_up_params)
    if user.save!
      render json: { message: "User created successfully." }, status: :ok
    end

  rescue => e
    render json: { error: "User creation failed => #{e.message}" }, status: :unprocessable_entity
  end

  private

  def sign_up_params
    params.fetch(:user).permit([:password, :email, :first_name, :last_name])
  end

end