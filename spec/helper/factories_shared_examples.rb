require "rails_helper"

RSpec.shared_examples "shared examples" do |factory_name, klass|
  describe "#{factory_name} factory" do
    subject { create factory_name }
    it { should be_an_instance_of klass }
    it { should be_valid }
    it { should be_persisted }
    it { should be_visible }
  end
end

RSpec.shared_examples "user examples" do |factory_name, klass|
  describe factory_name do
    let(:site_role) { factory_name.to_s.split('_').first.to_sym }
    subject { build factory_name }
    it "should have correct site_role" do
      expect(subject.site_role).to eq site_role.to_s
    end
    it "should allow a :invisible trait" do
      subject = create factory_name.to_sym, :invisible
      expect(subject.visible?).to eq false
    end
    it "should allow a :visible trait" do
      subject = create factory_name.to_sym, :visible
      expect(subject.visible?).to be true
    end
  end
end

RSpec.shared_examples "user trait examples" do |factory_name, owner, vis|
  describe "#{factory_name} traits [#{owner}, #{vis}]" do
    subject { build factory_name, owner, vis }
    it "should have correct site_role" do
      expect(subject.site_role).to eq owner.to_s
    end
    it "should have correct vis" do
      if vis == :invisible
        expect(subject.visible?).to be_falsey
      else
        expect(subject.visible?).to be_truthy
      end
    end
  end
end

RSpec.shared_examples "organization examples" do |factory_name, klass|
  describe factory_name do
    let(:site_role) { factory_name.to_s.split('_').first }
    subject { build factory_name.to_sym }
    it "should have correct owner" do
      expect(subject.owner.site_role).to eq site_role
    end
    it "should allow a :invisible trait" do
      subject = create factory_name.to_sym, :invisible
      expect(subject.visible).to be false
    end
  end
end
RSpec.shared_examples "organization trait examples" do |factory_name, owner, vis|
  describe "#{factory_name} traits [#{owner}, #{vis}]" do
    subject { build factory_name, owner, vis }
    it "should have correct owner" do
      expect(subject.owner.site_role).to eq owner.to_s
    end
    it "should have correct vis" do
      if vis == :invisible
        expect(subject.visible).to be_falsey
      else
        expect(subject.visible).to be_truthy
      end
    end
    it "should allow a :invisible trait" do
      subject = build factory_name, :invisible
      expect(subject.visible).to be false
    end
  end
end
