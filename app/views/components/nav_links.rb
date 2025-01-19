# frozen_string_literal: true

module NavLinks
  DELETE_DATA = { turbo_method: :delete, turbo_confirm: "Are you sure?" }

  def guest_home
    btn :nav, guests_home_path, icon: :house, title: "Guest Home"
  end

  def registered_home
    btn :nav, members_home_path, icon: :house, title: "Registered Home"
  end

  def show_user
    btn :nav, user_path(current_user), icon: :user, title: "User Profile"
  end

  def edit_user
    btn :nav, edit_user_path(current_user), icon: :pen, title: "Edit User Profile"
  end

  def organizations
    btn :nav, organizations_path, icon: :sitemap, title: "Organization"
  end

  def login
    btn :nav, sign_in_path, icon: :right_to_bracket, title: "Login"
  end

  def logout
    btn :nav, sign_out_path, icon: :right_from_bracket, title: "Logout", data: DELETE_DATA
  end

  def users
    btn :nav, users_path, icon: :users, title: "Users"
  end
end
