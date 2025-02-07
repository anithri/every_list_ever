class OrganizationsController < AuthenticationController
  before_action :require_login
  before_action :set_organization, only: %i[ show edit update destroy ]
  add_breadcrumb "Every List Ever", :root_path

  add_breadcrumb "Organizations", :organizations_path
  # GET /organizations or /organizations.json
  def index
    authorize current_user, :index?
    @organizations = policy_scope(Organization)
  end

  # GET /organizations/1 or /organizations/1.json
  def show
    authorize @organization
    add_breadcrumb @organization.name, @organization
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
    authorize @organization
    add_breadcrumb "New Org", :new_organization_path
  end

  # GET /organizations/1/edit
  def edit
    authorize @organization
    add_breadcrumb @organization.name, @organization
    add_breadcrumb "Edit", :edit_organization_path
  end

  # POST /organizations or /organizations.json
  def create
    @organization = Organization.new(organization_params)
    authorize @organization
    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: "Organization was successfully created." }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1 or /organizations/1.json
  def update
    authorize @organization
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: "Organization was successfully updated." }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1 or /organizations/1.json
  def destroy
    authorize @organization
    @organization.destroy!

    respond_to do |format|
      format.html { redirect_to organizations_path, status: :see_other, notice: "Organization was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def organization_params
    params.expect(organization: [ :name, :subtitle, :description, :visible ])
  end
end
