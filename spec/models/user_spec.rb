require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe User, type: :model do
  let (:user) { User.new }

  context 'When parameter is empty' do  # (almost) plain English
    it 'return invalid ActiveRecords on #create' do   #
      expect { User.create! }.to raise_error(ActiveRecord::RecordInvalid)  # test code
    end
  end

  context "When required parameter are available" do
    it "has 1 users after #create" do
      User.create(first_name: "Manish", last_name: "Shrestha", email: "abc@example.com", password_digest: "abc")
      expect(User.count).to eq(1)
    end
  end

  context "when first_name is empty" do
    it "should not save" do
      expect(user.save).to be false
    end
  end

  end
