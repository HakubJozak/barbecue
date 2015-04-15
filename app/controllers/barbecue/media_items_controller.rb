class Barbecue::MediaItemsController < Barbecue::ApplicationController
  respond_to :json

  before_action :find_media_item, except: [:index,:create]

  # GET /admin/media_items
  def index
    @media_items = items.all
    render json: @media_items, each_serializer: Barbecue::MediaItemSerializer
  end

  # GET /admin/media_items/1
  def show
    render json: @media_item, serializer: Barbecue::MediaItemSerializer
  end

  # POST /admin/media_items
  def create
    @media_item = items.new(media_item_params)
    if @media_item.save
      render json: @media_item, serializer: Barbecue::MediaItemSerializer
    else
      render json: { errors:  @media_item.errors }, status: 422
    end
  end

  # PATCH/PUT /admin/media_items/1
  def update
    if @media_item.update(media_item_params)
      render json: @media_item, serializer: Barbecue::MediaItemSerializer
    else
      render json: { errors:  @media_item.errors }, status: 422
    end
  end

  # DELETE /admin/media_items/1
  def destroy
    @media_item.destroy
    head :no_content
  end

  private

  def find_media_item
    @media_item = items.find(params[:id])
  end

  def items
    type = params.delete(:type) || params[:media_item].try(:delete,:type)
    case type.try(:downcase)
    when 'video' then Video
    when 'youtube_video' then YoutubeVideo
    when 'image' then Image
    else Barbecue::MediaItem
    end
  end

  def media_item_params
    params.require(:media_item).permit(:title_en,:url_original,:title_cs,:cover_url, :youtube_playlist_url)
  end

end
