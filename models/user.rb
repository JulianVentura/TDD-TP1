class User
  include ActiveModel::Validations

  attr_accessor :id, :name, :email, :crypted_password, :job_offers, :updated_on, :created_on

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  VALID_PASSWORD_SYMBOLS = ['$', ')', '_'].freeze
  NUMBER_REGEX = /\d/.freeze

  validates :name, :crypted_password, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX,
                                              message: 'invalid email' }

  def validate_password(password)
    if password.size < 8
      errors.add :password, 'password must contain at least 8 characters'
      raise_validation_error
    end
    unless VALID_PASSWORD_SYMBOLS.any? { |c| password.include? c }
      errors.add :password, 'password must contain at least 1 of these special characters $ ) _'
      raise_validation_error
    end

    if password.match(NUMBER_REGEX).nil?
      errors.add :password, 'password must contain at least 1 number'
      raise_validation_error
    end
  end

  def initialize(data = {})
    @id = data[:id]
    @name = data[:name]
    @email = data[:email]
    @crypted_password = if data[:password].nil?
                          data[:crypted_password]
                        else
                          validate_password(data[:password])
                          Crypto.encrypt(data[:password])
                        end
    @job_offers = data[:job_offers]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    validate!
  end

  def has_password?(password)
    Crypto.decrypt(crypted_password) == password
  end
end
