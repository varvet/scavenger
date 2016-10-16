require "scavenger/config"
require "scavenger/view_helpers"
require "scavenger/compressor"

module Scavenger
  module Rails
    class Engine < ::Rails::Engine
      def initialize
        super
        Config.svg_directory = ::Rails.root.join("app", "assets", "svg")
        Config.sprite_path = ::Rails.root.join("app", "assets", "images", "sprite.svg")
      end
    end
  end
end
