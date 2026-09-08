class PlayersController < ApplicationController
  def show
    name = params[:name].to_s
    raise ActionController::RoutingError, "Not Found" unless name.match?(/\A[a-zA-Z0-9_-]+\z/)

    file_path = Rails.root.join("data", "players", "#{name}.json")
    player = JSON.parse(File.read(file_path))

    @player_name = file_path.basename(".json").to_s
    @country = player.fetch("country")
    @items = player.fetch("factoids").sample(4)
    @side = params[:side] == "right" ? "right" : "left"

    avatar_path = Rails.root.glob("app/assets/images/avatars/#{@player_name}.*").first
    @avatar = "avatars/#{avatar_path.basename}" if avatar_path
  rescue Errno::ENOENT
    raise ActionController::RoutingError, "Not Found"
  end
end
