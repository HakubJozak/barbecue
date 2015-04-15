class Barbecue::MediaPlacementsController < Barbecue::ApplicationController
  respond_to :json

  before_action :find_media_placement, except: [:index,:create]

  # GET /admin/media_placements
  def index
    if ids = params.permit(ids: [])[:ids]
      @media_placements = MediaPlacement.joins(:media_item).find(ids)
      render json: @media_placements, each_serializer: Admin::MediaPlacementSerializer
    else
      head :no_content
    end
  end

  # GET /admin/media_placements/1
  def show
    render json: @media_placement, serializer: Admin::MediaPlacementSerializer
  end

  # POST /admin/media_placements
  def create
    @media_placement = MediaPlacement.new(media_placement_params)
    if @media_placement.save
      render json: @media_placement, serializer: Admin::MediaPlacementSerializer
    else
      render json: { errors:  @media_placement.errors }, status: 422
    end
  end

  # PATCH/PUT /admin/media_placements/1
  def update
    if @media_placement.update(media_placement_params)
      render json: @media_placement, serializer: Admin::MediaPlacementSerializer
    else
      render json: { errors:  @media_placement.errors }, status: 422
    end
  end

  # DELETE /admin/media_placements/1
  def destroy
    @media_placement.destroy
    head :no_content
  end

  def insert_at
    position = params[:position].to_i-1
    @media_placement.insert_at(position)
    render json: @media_placement.page.media_placements, each_serializer: Admin::MediaPlacementSerializer
  end

  private

  def find_media_placement
    @media_placement = MediaPlacement.find(params[:id])
  end

  def media_item_attributes
    [:copyright_en, :copyright_cs, :source_url, :id]
  end

  def media_placement_params
    required = params.require(:media_placement)
    required[:media_item_attributes] = required.delete(:media_item)
    required.permit(:is_plan,:cover_columns,:title_en,:title_cs,:"media_item.source_url",
                    :position, :media_item_id, media_item_attributes: media_item_attributes)
  end
end
