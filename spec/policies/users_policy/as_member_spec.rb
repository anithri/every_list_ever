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
    context "when user is a member" do
      permissions :index? do
        it 'should allow member users in all cases' do
          expect(subject).to permit(member, subject)
        end
      end

      permissions :show? do
        it 'it denies member to show invisible' do
          expect(subject).not_to permit(member, invisible)
        end
        it 'it allows members to show visible' do
          expect(subject).to permit(member, visible)
        end
        it 'it allows owner to show own in all cases' do
          expect(subject).to permit(member, member)
        end
      end

      permissions :create? do
        it 'should deny member to create another' do
          expect(subject).not_to permit(member, incomplete)
        end
      end

      permissions :update? do
        it 'should allow member when owner' do
          expect(subject).to permit(member, member)
        end
        it 'should denies member when not owner' do
          expect(subject).not_to permit(member, admin)
          expect(subject).not_to permit(member, guest)
          expect(subject).not_to permit(member, visible)
          expect(subject).not_to permit(member, invisible)
        end
      end

      permissions :destroy? do
        it 'should denies member when not owner' do
          expect(subject).not_to permit(member, member)
        end
        it 'should denies member when not owner' do
          expect(subject).not_to permit(member, admin)
          expect(subject).not_to permit(member, guest)
          expect(subject).not_to permit(member, visible)
          expect(subject).not_to permit(member, invisible)
        end
      end
    end
  end
end
