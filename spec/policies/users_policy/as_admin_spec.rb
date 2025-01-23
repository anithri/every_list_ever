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

    context "when user is an admin" do
      let(:users) { [admin, guest, member, visible, invisible]}
      permissions :index? do
        it 'should allow in all cases' do
          expect(subject).to permit(admin, subject)
        end
      end

      permissions :show? do
        it 'allows all' do
          expect(subject).to permit(admin, invisible)
          expect(subject).to permit(admin, visible)
          expect(subject).to permit(admin, admin)
          expect(subject).to permit(admin, guest)
          expect(subject).to permit(admin, member)
        end
      end

      permissions :create? do
        it 'should allow' do
          expect(subject).to permit(admin, incomplete)
        end
      end

      permissions :update? do
        it 'should allow in all cases' do
          expect(subject).to permit(admin, invisible)
          expect(subject).to permit(admin, visible)
          expect(subject).to permit(admin, admin)
          expect(subject).to permit(admin, guest)
          expect(subject).to permit(admin, member)
        end
      end

      permissions :destroy? do
        it 'should allow in all cases' do
          expect(subject).to permit(admin, invisible)
          expect(subject).to permit(admin, visible)
          expect(subject).to permit(admin, admin)
          expect(subject).to permit(admin, guest)
          expect(subject).to permit(admin, member)
        end
      end
    end
  end
end
