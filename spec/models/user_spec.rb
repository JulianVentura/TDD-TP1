require 'spec_helper'

describe User do
  subject(:user) do
    described_class.new(name: 'John Doe', email: 'john@doe.com',
                        crypted_password: 'a_secure_pa$$W0rd!')
  end

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:crypted_password) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:job_offers) }
  end

  describe 'valid?' do
    it 'should be invalid when name is blank' do
      check_validation(:name, "Name can't be blank") do
        described_class.new(email: 'john.doe@someplace.com',
                            crypted_password: 'a_secure_pa$$W0rd!')
      end
    end

    it 'should be invalid when email is not valid' do
      check_validation(:email, 'Email invalid email') do
        described_class.new(name: 'John Doe', email: 'john',
                            crypted_password: 'a_secure_pa$$W0rd!')
      end
    end

    it 'should be invalid when password is blank' do
      check_validation(:crypted_password, "Crypted password can't be blank") do
        described_class.new(name: 'John Doe', email: 'john@doe.com')
      end
    end

    it 'should be invalid when password is shorter than 8 characters' do
      check_validation(:password, 'Password password must contain at least 8 characters') do
        described_class.new(name: 'John Doe', email: 'john@doe.com', password: 'short')
      end
    end

    it 'should be invalid when password does not have a $ ) _ symbol' do
      check_validation(:password, 'Password password must contain at least 1 of these special characters $ ) _') do
        described_class.new(name: 'John Doe', email: 'john@doe.com', password: 'notasecurepassW0rd')
      end
    end

    it 'should be invalid when password does not have number' do
      check_validation(:password, 'Password password must contain at least 1 number') do
        described_class.new(name: 'John Doe', email: 'john@doe.com', password: 'notasecurepa$$Word')
      end
    end

    it 'should be valid when all field are valid' do
      user = described_class.new(name: 'John Doe', email: 'john@doe.com',
                                 crypted_password: 'a_secure_pa$$W0rd!')
      expect(user.valid?).to eq true
    end
  end

  describe 'has password?' do
    let(:password) { 'a_secure_pa$$W0rd!' }
    let(:user) do
      described_class.new(password: password,
                          email: 'john.doe@someplace.com',
                          name: 'john doe')
    end

    it 'should return false when password do not match' do
      expect(user).not_to have_password('invalid')
    end

    it 'should return true when password do  match' do
      expect(user).to have_password(password)
    end
  end
end
