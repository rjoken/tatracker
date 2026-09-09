class AvatarsController < ApplicationController
  include PlayerLookup

  def show
    scale = Integer(params[:scale], exception: false)
    @scale = [[scale || 64, 1].max, 1024].min

    avatar_path = avatar_file(requested_name)
    raise ActionController::RoutingError, "Not Found" unless avatar_path

    @player_name = avatar_path.basename(avatar_path.extname).to_s
    @avatar = "avatars/#{avatar_path.basename}"
    render layout: false
  end
end
