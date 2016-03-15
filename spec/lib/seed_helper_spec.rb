require 'spec_helper'

describe SeedHelper do

  describe '.find_or_create_resource' do
    subject { SeedHelper.find_or_create_resource(User, {email: email}, additional_args) }
    let(:email) { "jordan@example.com" }

    it "can build the object via a block" do
      new_user = SeedHelper.find_or_create_resource(User, {email: email}) do
        User.new(email: "jordan.rules@example.com")
      end

      expect(new_user).to be_kind_of(User)
      expect(new_user.email).to eq("jordan.rules@example.com")
    end

    context "without providing additional args" do
      let(:additional_args) { {} }

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

    context "providing additional args" do
      let(:additional_args) { {name: "Name"} }

      context "when a matching resource exists" do
        let!(:user) { User.create(email: email, name: "Other name") }

        it "only matches on identifiable args" do
          expect(subject).to eq(user)
        end
      end

      context "when no resource exists" do
        it "creates a new item with the identifiable attributes and the additional attributes" do
          expect(User.count).to eq(0)
          new_user = subject
          expect(User.count).to eq(1)
          expect(new_user).to be_kind_of(User)
          expect(new_user.email).to eq(email)
          expect(new_user.name).to eq("Name")
        end
      end
    end

  end

end
