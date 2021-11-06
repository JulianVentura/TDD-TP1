class JobApplication
  include ActiveModel::Validations

  attr_accessor :applicant_email, :job_offer, :cv_url

  validates :applicant_email, :job_offer, presence: true

  def initialize(email, offer, cv_url)
    @applicant_email = email
    @job_offer = offer
    @cv_url = cv_url
    validate!
  end

  def self.create_for(email, offer, cv_url = '')
    JobApplication.new(email, offer, cv_url)
  end

  def process
    JobVacancy::App.deliver(:notification, :contact_info_email, self)
    @job_offer.apply
  end
end
