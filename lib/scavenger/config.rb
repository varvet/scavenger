module Scavenger
  module Config
    class << self
      attr_accessor :svg_directory
      attr_accessor :sprite_path
      attr_accessor :class_prefix
    end

    self.svg_directory = nil
    self.sprite_path = nil
    self.class_prefix = nil
  end
end
