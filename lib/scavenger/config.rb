module Scavenger
  module Config
    class << self
      attr_accessor :svg_directory
      attr_accessor :sprite_path
    end

    self.svg_directory = nil
    self.sprite_path = nil
  end
end
