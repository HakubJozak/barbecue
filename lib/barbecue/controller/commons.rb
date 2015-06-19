module Barbecue::Controller::Commons
  
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

  def default_format_json
    if request.headers["HTTP_ACCEPT"].nil? && params[:format].nil?
      request.format = "json"
    end
  end

  def render_error(model)
    full = model.errors.full_messages.join('. ')
    render json: { errors: model.errors, full_message: "#{full}." }, status: 422
  end

  def menu_item_attrs
    [ :id, :title_en, :title_cs, :parent_id, :position ]
  end


end
