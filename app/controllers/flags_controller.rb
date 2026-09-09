class FlagsController < ApplicationController
  include PlayerLookup

  def show
    file_path = player_file(requested_name)
    raise ActionController::RoutingError, "Not Found" unless file_path

    player = JSON.parse(File.read(file_path))
    country = player.fetch("country")

    flag_path = flag_file(country)
    raise ActionController::RoutingError, "Not Found" unless flag_path

    @country = country
    @flag = "flags/#{flag_path.basename}"
    render layout: false
  end
end
