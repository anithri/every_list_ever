# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:admin) { create(:admin_user) }
  let(:guest) { create(:guest_user) }
  let(:member) { create(:member_user) }
  let(:invisible) { create(:member_user) }

  subject { described_class }

  describe "UserPolicy::Scope" do

  end

  describe "user can use action" do

    permissions ".scope" do
      pending "add some examples to (or delete) #{__FILE__}"
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
