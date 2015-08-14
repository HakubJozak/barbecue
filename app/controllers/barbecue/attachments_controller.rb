class Barbecue::AttachmentsController < Barbecue::ApplicationController

  def create
    params.require(:attachment).permit(:file)
  end
end
