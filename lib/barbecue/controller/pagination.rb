module Barbecue::Controller::Pagination

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

end
