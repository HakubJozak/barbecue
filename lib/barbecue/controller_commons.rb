module Barbecue::ControllerCommons

  private

  # Usage:
  #
  #   layout :admin_or_application
  # 
  def admin_or_application
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def pagination_info(scope)
    {
      total: scope.total_count,
      per_page: scope.size,
      total_pages: scope.total_pages,
      pagination_bits: Paginator.new(scope,left: 2,right: 2).pagination_bits,
      current_page: current_page
    }
  end

  def per_page
    params[:per_page] || params[:per] || 10
  end

  def current_page
    params[:p] || params[:page] || 1
  end

  def default_format_json
    if request.headers["HTTP_ACCEPT"].nil? && params[:format].nil?
      request.format = "json"
    end
  end

  def render_error(model)
    full = model.errors.full_messages.join('. ')
    render json: { errors: model.errors, full_message: "#{full}." }, status: 422
  end
  
  
  
end
