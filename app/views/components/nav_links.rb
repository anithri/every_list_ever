# frozen_string_literal: true

module NavLinks

  def guest_home
    component :link_button, root_path, :nav, title: "Guest HomeComponent" do
      component :icon, :house
    end
  end

  def member_home
    component :link_button, members_home_path, :nav, title: "Member HomeComponent" do
      component :icon, :house
    end
  end

  def show_user
    component :link_button, user_path(current_user), :nav, title: "User Profile" do
      component :icon, :user
    end
  end

  def edit_user
    component :link_button, edit_user_path(current_user), :nav, title: "Edit User Profile" do
      component :icon, :pen
    end
  end

  def login
    component :link_button,
              new_session_path,
              :nav,
              title: "Login" do
      component :icon, :right_to_bracket
    end
  end

  def logout
    component :link_button, session_path, :nav, title: "Logout",
              data: { turbo_method: :delete, turbo_confirm: "Are you sure?" } do
      component :icon, :right_from_bracket
    end
  end

  def users
    component :link_button, users_path, :nav, title: "Users" do
      component :icon, :users
    end
  end
end

