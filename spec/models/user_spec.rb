require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a first name, last name and email (valid user factory)' do
    expect(build(:user).valid?).to be_truthy
  end
  it 'is invalid without a first name' do
    expect(build(:user, first_name: nil).valid?).to be_falsey
  end
  it 'is invalid without a last name' do
    expect(build(:user, last_name: nil).valid?).to be_falsey
  end
  it 'is invalid without an email address' do
    expect(build(:user, email: nil).valid?).to be_falsey
  end
  it 'email match Devise email format' do
    expect(build(:user, email: 'some.string').valid?).to be_falsey
  end
  it 'returns a user`s full name as a string' do
    user = build(:user)
    expect(user.name).to eq "#{user.first_name} #{user.last_name}"
  end
  it 'is not administrator by default' do
    expect(build(:user).administrator).to be_falsey
  end
end
