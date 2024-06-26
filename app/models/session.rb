class Session < ApplicationRecord
    belongs_to :user

    def self.new_session(user)
        session = Session.new
        session.salt = SecureRandom.base64(40)
        session.session_key = SecureRandom.base64(60)
        session.user_id = user.id
        session.expires_at = 14.days.from_now
        session.auth_token = session.encode_token
        session.save!
        session
    end

    def encode_token
        payload = {}
        payload[:session_key] = session_key
        payload[:expires_at] = expires_at
        JWT.encode(payload, salt)
    end

    def decode_token
        decoded = JWT.decode(auth_token, salt)
        HashWithIndifferentAccess.new decoded[0]
    end

    def expired?
        expires_at.to_i <= Time.now.to_i ? true : false
    end

    def logout
        self.delete
    end
end
