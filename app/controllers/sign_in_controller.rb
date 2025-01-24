class SignInController < Clearance::BaseController
  def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_back_or url_after_create
      else
        flash.now.alert = status.failure_message
        render status: :unauthorized
      end
    end
  end

  def destroy
    sign_out
    redirect_to url_after_destroy, status: :see_other
  end

  def new
    render template: "sign_in/new"
  end

  private

  def redirect_signed_in_users
    if signed_in?
      redirect_to url_for_signed_in_users
    end
  end

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def url_after_destroy
    Clearance.configuration.url_after_destroy || sign_in_url
  end

  def url_for_signed_in_users
    url_after_create
  end
end
