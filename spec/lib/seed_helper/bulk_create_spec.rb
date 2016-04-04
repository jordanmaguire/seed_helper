require 'spec_helper'

describe SeedHelper::BulkCreate do

  describe '#bulk_create' do
    subject { SeedHelper.bulk_create(User, identifiable_attributes) { User.create(email: email)} }

    let(:email) { "jordan@example.com" }

    context "with identifiable_attributes" do
      let(:identifiable_attributes) { {email: email} }

      context "when a User with those attributes already exists" do
        before { User.create!(email: email) }

        it "sends an 'already exists' message" do
          expect(SeedHelper).to receive(:resource_already_exists).with("Users ({:email=>\"jordan@example.com\"})")
          subject
        end
      end

      context "when no User with those attributes already exists" do
        before { User.create!(email: "other@example.com") }

        it "runs the given block" do
          expect { subject }.to change { User.count }.by(1)
        end

        it "prints a success message" do
          expect(SeedHelper).to receive(:success).with("Created Users ({:email=>\"jordan@example.com\"})")
          subject
        end
      end
    end

    context "with no identifiable_attributes" do
      let(:identifiable_attributes) { {} }

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

end
