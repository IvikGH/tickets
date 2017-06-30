require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before(:each) do
    create(:department)
    create(:status)
  end

  it 'has valid factory' do
    expect(build(:ticket).valid?).to be_truthy
  end

  describe 'validations' do
    it 'is invalid without a status_id' do
      expect(build(:ticket, status_id: nil).valid?).to be_falsey
    end
    it 'is invalid without department_id' do
      expect(build(:ticket, department_id: nil).valid?).to be_falsey
    end
    it 'is invalid without subject' do
      expect(build(:ticket, subject: nil).valid?).to be_falsey
    end
    it 'is invalid without description' do
      expect(build(:ticket, description: nil).valid?).to be_falsey
    end
    it 'is invalid without employee' do
      expect(build(:ticket, employee: nil).valid?).to be_falsey
    end
    it 'is invalid without employee_email' do
      expect(build(:ticket, employee_email: nil).valid?).to be_falsey
    end
    it 'is invalid without uniq_reference' do
      expect(build(:ticket, uniq_reference: nil).valid?).to be_falsey
    end
    it 'is valid without user_id' do
      expect(build(:ticket, user_id: nil).valid?).to be_truthy
    end
    it 'user_id must be only numerical' do
      expect(build(:ticket, user_id: 3).valid?).to be_truthy
      expect(build(:ticket, user_id: 'John Doe').valid?).to be_falsey
    end
    it 'employee_email match Devise email format' do
      expect(build(:ticket, user_id: 'xxx@yyy.').valid?).to be_falsey
    end
    it 'email match validation format' do
      expect(build(:ticket, employee: 'John').valid?).to be_falsey
      expect(build(:ticket, employee: 'John Doe').valid?).to be_truthy
      expect(build(:ticket,
                   employee: 'John Smith Adam Johnson Abrams').valid?).to be_truthy
    end
    it 'uniq_reference is formated and must be 17 symbols long' do
      value = '278-CB-5EB-85178'
      expect(build(:ticket, uniq_reference: value).valid?).to be_falsey
      value = '2781CB15EB1851178'
      expect(build(:ticket, uniq_reference: value).valid?).to be_falsey
      value = '278-CB-5EB-85-17822'
      expect(build(:ticket, uniq_reference: value).valid?).to be_falsey
    end
  end
end
