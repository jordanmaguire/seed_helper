require 'spec_helper'

describe SeedHelper::BulkCreate do

  describe '#bulk_create' do
    subject { SeedHelper.bulk_create(User) { User.create(email: email)} }

    let(:email) { "jordan@example.com" }

    context "when a User already exists" do
      before { User.create! }

      it "sends an 'already exists' message" do
        expect(SeedHelper).to receive(:resource_already_exists).with("Users")
        subject
      end
    end

    context "when no Users exist" do
      it "runs the given block" do
        expect { subject }.to change { User.count }.to(1)
      end

      it "prints a success message" do
        expect(SeedHelper).to receive(:success).with("Created Users")
        subject
      end
    end
  end

end
