class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  def authentication_api_user!
    head(:unauthorized) unless user_signed_in?
  end
  alias_method :authentication_user!, :authentication_api_user!
end
