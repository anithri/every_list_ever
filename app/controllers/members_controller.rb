class MembersController < ApplicationController
  def home
    authorize :members_home
  end
end