class PlayersController < ApplicationController
  include PlayerLookup

  def show
    file_path = player_file(requested_name)
    raise ActionController::RoutingError, "Not Found" unless file_path

    player = JSON.parse(File.read(file_path))

    @player_name = file_path.basename(".json").to_s
    @country = player.fetch("country")
    @items = player.fetch("factoids").sample(4)
    @side = params[:side] == "right" ? "right" : "left"

    avatar_path = avatar_file(@player_name)
    @avatar = "avatars/#{avatar_path.basename}" if avatar_path
  end
end
