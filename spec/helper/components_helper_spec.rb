# frozen_string_literal: true

RSpec.describe 'ComponentsHelper', type: :helper do
  # import 'ComponentsHelper'
  # let (:helper) { Class.new { extend ComponentsHelper } }

  before do

    # Do nothing
  end

  after do
    # Do nothing
  end

  describe "#component" do

  end

  describe "#view_class(controller, name)" do
    it "returns existing view class " do
      # klass = helper.view_class(:rails, :application)
      # expect(klass).to be(Rails::Application)
    end

    it "raise Error when the class does not exist" do
      # expect { helper.view_class(:rails, :non_existing) }.to raise_error(NameError)
    end

  end

  describe '#view' do
  end
end
