# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  after(:each) do
    User.delete_all
  end
  let(:admin) { create(:admin_user) }
  let(:guest) { create(:guest_user) }
  let(:member) { create(:member_user) }
  let(:invisible) { create(:member_user, visible: false) }
  let(:visible) { create(:member_user, visible: true) }

  subject { described_class }

  # TODO better understand how to load data into tests without duplications
  describe "UserPolicy::Scope" do
    before(:each) {[admin, guest, member, invisible, visible]}
    permissions :scope do
      it 'should allow admin users to return all users' do
        expected_count = User.count
        resolved = subject::Scope.new(admin, User).resolve
        expect(resolved.count).to eq(expected_count)
      end
      it 'should allow guest users to return no users' do
        expected_count = 0
        resolved = subject::Scope.new(guest, User).resolve
        expect(resolved.count).to eq(expected_count)
      end
      it 'should allow member users to return all visible plus themselves' do
        expected_count = User.visible.count + (member.visible? ? 0 : 1)
        resolved = subject::Scope.new(member, User).resolve
        expect(resolved.count).to eq(expected_count)
      end
    end
  end

  describe "user can use action" do
    permissions :index? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, guest)
      end
      it 'should deny guest users in all cases' do
        expect(subject).not_to permit(guest, guest)
      end
      it 'should allow member users in all cases' do
        expect(subject).to permit(member, member)
      end
    end

    permissions :show? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, guest)
      end
      it 'should deny guest users in all cases' do
        expect(subject).not_to permit(guest, guest)
      end
      it 'should allow owner to show own' do
        expect(subject).to permit(member, member)
      end
      it 'should deny member to show others' do
        expect(subject).not_to permit(member, admin)
        expect(subject).not_to permit(member, guest)
      end
    end

    permissions :create? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, guest)
      end
      it 'should allow guest users in all cases' do
        expect(subject).to permit(guest, member)
      end
      it 'should deny member to create another' do
        expect(subject).not_to permit(member, guest)
      end
    end

    permissions :update? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, guest)
      end
      it 'should deny guest users in all cases' do
        expect(subject).not_to permit(guest, guest)
      end
      it 'should allow owner to update own' do
        expect(subject).to permit(member, member)
      end
      it 'should deny members for all but own' do
        expect(subject).not_to permit(member, admin)
        expect(subject).not_to permit(member, guest)
      end
    end

    permissions :destroy? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, admin)
        expect(subject).to permit(admin, guest)
        expect(subject).to permit(admin, member)
      end
      it 'should deny guest users in all cases' do
        expect(subject).not_to permit(guest, guest)
        expect(subject).not_to permit(guest, admin)
        expect(subject).not_to permit(guest, member)
      end
      it 'should deny members in all cases' do
        expect(subject).not_to permit(member, guest)
        expect(subject).not_to permit(member, admin)
        expect(subject).not_to permit(member, member)
      end
    end
  end
end
