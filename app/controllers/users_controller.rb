class UsersController < Clearance::UsersController
  include Pundit::Authorization

  before_action :set_user, only: %i[ show edit update destroy ]
  add_breadcrumb "Every List Ever", :root_path
  add_breadcrumb "Users", :users_path
  # GET /users or /users.json
  def index
    authorize User
    @users = policy_scope(User)
  end

  # GET /users/1 or /users/1.json
  def show
    authorize @user
    add_breadcrumb @user.name, @user
  end

  # GET /users/1/edit
  def edit
    authorize @user
    add_breadcrumb @user.name, @user
    add_breadcrumb "Edit", edit_user_path(@user)
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    authorize @user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    authorize @user
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = policy_scope(User).find_by_id(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.expect(user: [ :email, :name, :visible, :avatar_url, :description, :location ])
  end
end
