class User < ApplicationRecord
    has_secure_password
    has_many :sessions
    validates :first_name, presence: true, uniqueness: { case_sensitive: false, message: "Already taken"},format: { with: /\A[a-zA-Z0-9_]*[a-zA-Z][a-zA-Z0-9_]*\z/, message: "Required condition not met" }
    validates :password_digest, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false, message: 'Address is Already Registered !' }, format: { with: /\A[^@\s]+@[^@\s]+\z/i }

    def create_user(user_details)
        is_email_present = User.find_by(email: user_details[:email])
        raise "Email already exists" if is_email_present.present?
        self.email = user_details[:email]
        self.first_name = user_details[:first_name]
        if user_details[:last_name].present?
            raise "Lastname required condition not met" unless user_details[:last_name] =~ /\A[a-zA-Z0-9_]*[a-zA-Z][a-zA-Z0-9_]*\z/
            self.last_name = user_details[:last_name]
        end
        raise "Password condition not met" unless user_details[:password] =~ /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}\z/
        self.password = user_details[:password]
        save!
    end

    def login(password)
        is_password_valid = authenticate(password)
        raise "Incorrect Password" unless is_password_valid
        user_session = Session.new_session(self)
        raise "Session could not be created" unless user_session
        self.num_of_logins = num_of_logins.to_i + 1
        self.last_login_at = Time.now
        save!
        user_session.auth_token
    end
end
