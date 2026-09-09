class AvatarsController < ApplicationController
  def show
    name = params[:name].to_s
    raise ActionController::RoutingError, "Not Found" unless name.match?(/\A[a-zA-Z0-9_-]+\z/)

    scale = Integer(params[:scale], exception: false)
    @scale = [[scale || 64, 1].max, 1024].min

    avatar_path = Rails.root.glob("app/assets/images/avatars/#{name}.*").first
    raise ActionController::RoutingError, "Not Found" unless avatar_path

    @avatar = "avatars/#{avatar_path.basename}"
    render layout: false
  end
end
