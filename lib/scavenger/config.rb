module Scavenger
  module Config
    class << self
      attr_accessor :svg_directory
      attr_accessor :sprite_path
      attr_accessor :class_prefix
      attr_accessor :aspect_ratio
    end

    self.aspect_ratio = "xMinYMin meet"
  end
end
