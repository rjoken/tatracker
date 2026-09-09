class FlagsController < ApplicationController
  def show
    name = params[:name].to_s
    raise ActionController::RoutingError, "Not Found" unless name.match?(/\A[a-zA-Z0-9_-]+\z/)

    file_path = Rails.root.join("data", "players", "#{name}.json")
    player = JSON.parse(File.read(file_path))

    country = player.fetch("country")
    flag_path = Rails.root.join("app", "assets", "images", "flags", "#{country}.png")
    raise ActionController::RoutingError, "Not Found" unless flag_path.exist?

    @country = country
    @flag = "flags/#{country}.png"
    render layout: false
  rescue Errno::ENOENT
    raise ActionController::RoutingError, "Not Found"
  end
end
