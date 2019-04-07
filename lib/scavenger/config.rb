module Scavenger
  module Config
    class << self
      attr_accessor :svg_directory
      attr_accessor :sprite_path
      attr_accessor :class_prefix
      attr_accessor :id_prefix
      attr_accessor :aspect_ratio
    end

    self.aspect_ratio = "xMinYMin meet"
    self.id_prefix = ""
  end
end
