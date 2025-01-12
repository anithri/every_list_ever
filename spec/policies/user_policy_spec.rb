# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  after(:each) do
    User.delete_all
  end
  let(:admin) { create(:admin_user) }
  let(:guest) { create(:guest_user) }
  let(:member) { create(:member_user) }
  let(:invisible) { create(:member_user, visible: false, user: admin) }
  let(:visible) { create(:member_user, visible: true, user: admin) }

  subject { described_class }

  # TODO better understand how to load data into tests without duplications
  xdescribe "UserPolicy::Scope" do
    pending "learn better rspec database setup & cleanup & loading records"
    # it 'should allow admin to return all users ' do
    #   warn User.all.to_a.inspect
    #   expect(subject::Scope.new(admin, User).resolve.length).to match_array([admin, guest, member, invisible])
    # end
    # it 'should allow guest to return no users ' do
    #   expect(subject::Scope.new(guest, User).resolve.length).to match_array([])
    # end
    # it 'should allow member to return them self and all visible' do
    #   expect(subject::Scope.new(member, User).resolve.length).to match_array([admin, guest, member])
    # end
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
