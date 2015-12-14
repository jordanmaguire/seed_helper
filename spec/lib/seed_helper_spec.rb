require 'spec_helper'

describe SeedHelper do

  describe '.find_or_create_resource' do
    subject { SeedHelper.find_or_create_resource(User, {email: email}) }
    let(:email) { "jordan@example.com" }

    context "when resource already exists" do
      let!(:user) { User.create(email: email) }
      it { should eq(user) }
    end

    context "when resource doesn't exist" do
      it "creates a new Resource" do
        expect(User.count).to eq(0)
        new_user = subject
        expect(User.count).to eq(1)
        expect(new_user).to be_kind_of(User)
        expect(new_user.email).to eq(email)
      end
    end
  end

end