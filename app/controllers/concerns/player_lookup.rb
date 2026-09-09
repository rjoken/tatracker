module PlayerLookup
  extend ActiveSupport::Concern

  NAME_PATTERN = /\A[a-zA-Z0-9_-]+\z/

  private

  # Names come from URLs, so look files up without regard to case.
  def requested_name
    name = params[:name].to_s
    raise ActionController::RoutingError, "Not Found" unless name.match?(NAME_PATTERN)

    name
  end

  def player_file(name)
    find_file(Rails.root.join("data", "players"), "#{name}.json")
  end

  def avatar_file(name)
    find_file(Rails.root.join("app", "assets", "images", "avatars"), "#{name}.*")
  end

  def flag_file(country)
    find_file(Rails.root.join("app", "assets", "images", "flags"), "#{country}.png")
  end

  def find_file(dir, pattern)
    match = dir.children.find do |path|
      File.fnmatch?(pattern, path.basename.to_s, File::FNM_CASEFOLD)
    end
    match if match&.file?
  rescue Errno::ENOENT
    nil
  end
end
