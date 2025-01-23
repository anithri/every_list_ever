# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do

  subject { described_class }
  describe "action permissions" do
    let(:admin) { create :admin_user }
    let(:guest) { create :guest_user }
    let(:member) { create :member_user }
    let(:visible) { create :member_user, :visible }
    let(:invisible) { create :member_user, :invisible }
    let(:incomplete) { build :user }

    context "when user is an guest" do
      let(:users) { [admin, guest, member, visible, invisible]}
      permissions :index? do
        it 'should deny in all cases' do
          expect(subject).not_to permit(guest, subject)
        end
      end

      permissions :show? do
        it 'allows all' do
          expect(subject).not_to permit(guest, invisible)
          expect(subject).not_to permit(guest, visible)
          expect(subject).not_to permit(guest, admin)
          expect(subject).not_to permit(guest, guest)
          expect(subject).not_to permit(guest, member)
        end
      end

      permissions :create? do
        it 'should allow' do
          expect(subject).to permit(guest, incomplete)
        end
      end

      permissions :update? do
        it 'should deny in all cases' do
          expect(subject).not_to permit(guest, invisible)
          expect(subject).not_to permit(guest, visible)
          expect(subject).not_to permit(guest, admin)
          expect(subject).not_to permit(guest, guest)
          expect(subject).not_to permit(guest, member)
        end
      end

      permissions :destroy? do
        it 'should deny in all cases' do
          expect(subject).not_to permit(guest, invisible)
          expect(subject).not_to permit(guest, visible)
          expect(subject).not_to permit(guest, admin)
          expect(subject).not_to permit(guest, guest)
          expect(subject).not_to permit(guest, member)
        end
      end
    end
  end
end
