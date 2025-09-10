class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def configure_permitted_parameters
    # Use permit instead of for
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # If you want to allow additional fields on account update:
    # devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def require_admin
    if  !current_user.admin?
      flash[:alert] = "Access denied. Admins only."
      redirect_to root_path
    end
  end
  def require_employee
    if current_user.admin?
      flash[:alert] = "Access denied. Employees only."
      redirect_to root_path
    end
  end
def require_admin_or_employee
  unless current_user.admin? || current_user.employee?
    flash[:alert] = "Access denied."
    redirect_to root_path
  end
end
end
