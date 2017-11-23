module Api
  class V1::SessionsController < BaseController
    # POST /api/v1/sign_in
    # @return JSON
    def create
      user = User.find_by(email: user_params[:email])

      if user && user.valid_password?(user_params[:password])
        render json: { status: 'success', data: { user_token: user.authentication_token } }
      else
        render json: { status: 'error', error_message: 'Login or password is incorrect' }
      end
    end

    private

    def user_params
      params.permit(:email, :password)
    end
  end
end
