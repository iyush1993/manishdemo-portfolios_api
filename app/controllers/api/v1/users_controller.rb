module Api
  module V1
    class UsersController < ApplicationController

      def sign_up
        @user = User.create(user_params)
        if @user.valid?
          token = encode_token({user_id: @user.id})
          render json: {user: @user, token: token}
        else
          render json: {error: "Invalid username or password"}
        end
      end

      def sign_in
        email = params.dig(:auth, :email)
        password = params.dig(:auth, :password)

        if email.nil? || password.nil?
          render json: {error: "Email and password are required"}
          return
        end

        @user = User.find_by(email: email)

        # puts("got request raw post=> #{request.raw_post}")
        # puts("got params auth => #{params[:auth]}")
        # puts("got params email => #{params[:auth][:email]}")
        # puts("nil user=#{@user.nil?}")
        # puts("user=#{@user.to_s}")


        if @user && @user.authenticate(password)
          token = encode_token({user_id: @user.id})

          resp = {
            "data": {
              "id": @user.id,
              "type": "users",
              "attributes": {
                "token": token,
                "email": @user.email,
                "name": "#{@user.first_name} #{@user.last_name}",
                "country":  @user.country},
                "createdAt": @user.created_at,
                "updatedAt": @user.updated_at
            }
          }

          render json: resp
        else
          render json: {error: "Invalid email or password"}
        end

      rescue StandardError => authentication_error
        render json: {error: "Bad arguments"}
      end

      private
      def user_params
        params.permit(:first_name, :last_name, :email, :country)
      end


    end
  end
end