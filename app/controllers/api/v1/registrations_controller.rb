module Api
  class V1::RegistrationsController < BaseController
    # POST /api/v1/sign_up
    # @return JSON
    def create
      user = User.new(user_params.merge(password_confirmation: user_params[:password]))

      if user.save
        render json: { status: 'success', data: user.as_json(only: %i(id email)) }
      else
        render json: { status: 'error', error_messages: user.errors.messages }
      end
    end

    private

    def user_params
      params.permit(:email, :password)
    end
  end
end
