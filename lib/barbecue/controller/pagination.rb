module Barbecue::Controller::Pagination

  def pagination_info(scope)
    # is paginated?
    if scope.respond_to?(:total_count)
      {
        total: scope.total_count,
        per_page: scope.size,
        total_pages: scope.total_pages,
        pagination_bits: Paginator.new(scope,left: 2,right: 2).pagination_bits,
        current_page: current_page
      }
    else
      {}
    end
  end

  def per_page
    params[:per_page] || params[:per] || 10
  end

  def current_page
    params[:p] || params[:page] || 1
  end

  private

  class Paginator < Kaminari::Helpers::Paginator
    def initialize(scope,opts = {})
      opts = opts.merge(current_page: scope.current_page,
                        total_pages: scope.total_pages,
                        per_page: scope.limit_value)
      # `nil` for template param because we don't need rendering
      super(nil,opts)
    end

    def pagination_bits
      pages = self.each_relevant_page {}
      add_ellipsis(pages)
    end

    private

    # Adds '...' in the gaps between page numbers:
    #
    #     [1,2,3,10] => [1,2,3,'...',10]
    #
    def add_ellipsis(array)
      return array if array.empty?

      last = array[0] - 1

      array.map do |p|
        if p == last + 1
          last = p
          p
        else
          last = p
          ['...',p]
        end
      end.flatten
    end
  end


end
