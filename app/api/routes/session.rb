# frozen_string_literal: true

module Routes
  class Session < Grape::API
    format :json

    helpers do
      def permitted_params
        params.except(:password, :email)
      end

      def reply_with_logging(response)
        ApiLogger.log("info", response.merge(params: permitted_params))
        response
      end
    end

    desc "User register"
    params do
      requires :email, type: String
      requires :username, type: String
      requires :password, type: String
    end
    post :register do
      user = User.new(params)
      if user.save
        status :created
        Mailer.new(user.email, "Your account has been created", "new_account_created").deliver
        response = {
          status: "success",
          data: { user: user.to_h }
        }
      else
        status :unauthorized
        response = {
          status: "failure",
          data: { message: "Invalid/Taken email or username, try again." }
        }
      end
      reply_with_logging(response)
    end

    desc "User login"
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post :login do
      user = User.find_by(email: params[:email]).first
      if user.present? && user.password == params[:password]
        status :accepted
        response = {
          status: "success",
          data: {
            user: user.to_h,
            jwt: user.new_jwt
          }
        }
      else
        status :unauthorized
        response = {
          status: "failure",
          data: { message: "Incorrect credentials" }
        }
      end
      reply_with_logging(response)
    end
  end
end
