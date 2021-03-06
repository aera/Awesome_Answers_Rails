class Api::ApplicationController < ApplicationController
  # This will stop rails from raising an error if
  # a post does not have an authenticity token.
  # Authenticity tokens are generated by rails to
  # let it identify post requests as being submitted
  # from its own forms.
  skip_before_action :verify_authenticity_token

=begin
fetch(
  'http://localhost:3000/api/v1/questions',
  {
    headers: {
      'Authorization' : 'd5c234ff7b9b6bb96e7a125b8f6755ae539eb7e6b0ebabfc4dffe26f021059e8'
    }
  }
)
=end

  def current_user
    if token.present?
      case token_type
      when 'api_key', 'apikey'
        @user ||= User.find_by(api_key: token)
      when 'jwt'
        @user ||= User.find_by(id: payload[:id])
      end
    end
  end

  private
  # 'Authorization' : 'ApiKey AHJdJHDA898231jhlkAJDSLKa'
  # 'Authorization' : 'JWT    AHJdJHDA898231jhlkAJDSLKa.KAJLSDal9e9q.dJALJDAiIoqiuo_'
  def authorization_header
    request.headers['AUTHORIZATION']
  end

  def token
    authorization_header&.split(/\s+/)&.last
  end

  def token_type
    #APIKEY, apikey, ApiKey
    authorization_header&.split(/\s+/)&.first&.downcase
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
  end

  def payload
    # We don't want our application to crash if the JWT is invalid. We'll have
    # to rescue the error (this is Ruby's try .. catch) and just return a empty hash.
    begin
      # HashWithIndifferentAccess creates a special hash where its keys
      # can be accessed as symbols or strings.
      # (e.g. hsh[:id], hsh["id"])
      payload = HashWithIndifferentAccess.new decode_token(token)&.first

      # Validate the expiration in the payload
      return nil if Time.at(payload[:exp]) < Time.now
      payload
    rescue JWT::DecodeError => error
      {}
    end
  end

  def authenticate_user!
    head :unauthorized unless current_user.present?
  end
end
