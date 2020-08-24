# frozen_string_literal: true

module API::Routes
  class Session < Grape::API
    prefix :api
    format :json

    helpers do
      def permitted_params
        params.except(:password)
      end

      def reply_with_logging(response)
        logger.log(Logger::INFO, response.merge(params: permitted_params).to_s)
        response
      end


      def authorized?
        users = Settings.api.authorized_users.map(&:to_h)
        i = 0
        while i < users.size do
          if users[i][:username] == params[:username] && users[i][:password] == params[:password]
            return users[i][:username]
          end
          i = i + 1
        end
      end
    end

    desc "User login"
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post :login do
      if username = authorized?
        status :accepted
        response = {
          status: "success",
          data: {
            user: username,
            jwt: JwtTokenService.new.encode(username: username)
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
