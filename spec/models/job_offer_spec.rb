require 'spec_helper'

describe JobOffer do
  describe 'valid?' do
    it 'should be invalid when title is blank' do
      check_validation(:title, "Title can't be blank") do
        described_class.new(location: 'a location')
      end
    end

    it 'should be valid when title is not blank' do
      job_offer = described_class.new(title: 'a title')
      expect(job_offer).to be_valid
    end

    it 'should have 0 postulations when created' do
      job_offer = described_class.new(title: 'a title')
      expect(job_offer.postulants).to equal 0
    end

    it 'should have 1 postulations when applied once' do
      job_offer = described_class.new(title: 'a title')
      job_offer.apply
      expect(job_offer.postulants).to equal 1
    end
  end
end
