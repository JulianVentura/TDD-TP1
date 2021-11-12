require 'spec_helper'

describe JobApplication do
  let(:job_offer) { JobOffer.new(title: 'a title') }

  describe 'valid?' do
    it 'should be invalid when email is blank' do
      check_validation(:applicant_email, "Applicant email can't be blank") do
        described_class.create_for(nil, job_offer)
      end
    end

    it 'should be invalid when offer is blank' do
      check_validation(:job_offer, "Job offer can't be blank") do
        described_class.create_for('applicant@test.com', nil)
      end
    end

    it 'should be invalid when cv url is not a valid url' do
      check_validation(:cv_url, 'Cv url CV should be a link (example www.linkedin.com/mycv)') do
        described_class.create_for('applicant@test.com', job_offer, 'linkedin.com')
      end
    end
  end

  describe 'create_for' do
    it 'should set applicant_email' do
      email = 'applicant@test.com'
      ja = described_class.create_for(email, job_offer)
      expect(ja.applicant_email).to eq(email)
    end

    it 'should set job_offer' do
      offer = job_offer
      ja = described_class.create_for('applicant@test.com', offer)
      expect(ja.job_offer).to eq(offer)
    end

    it 'should set cv_url' do
      cv_url = 'www.linkedin.com/mylinkedin'
      offer = job_offer
      ja = described_class.create_for('applicant@test.com', offer, cv_url)
      expect(ja.cv_url).to eq(cv_url)
    end
  end

  describe 'process' do
    it 'should deliver contact info notification' do
      ja = described_class.create_for('applicant@test.com', job_offer)
      expect(JobVacancy::App).to receive(:deliver).with(:notification, :contact_info_email, ja)
      ja.process
    end

    it 'should increase job offer postulants counter by one' do
      prev_postulants = job_offer.postulants
      ja = described_class.create_for('applicant@test.com', job_offer)
      expect(JobVacancy::App).to receive(:deliver).with(:notification, :contact_info_email, ja)
      ja.process
      expect(job_offer.postulants).to eq(prev_postulants + 1)
    end
  end
end
