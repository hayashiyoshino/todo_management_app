require 'rails_helper'

RSpec.describe User, type: :model do
  it "#create" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

end
