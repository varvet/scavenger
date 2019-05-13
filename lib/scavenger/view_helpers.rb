module Scavenger
  module ViewHelpers
    def compressor
      @compressor ||= Scavenger::Compressor.new(Scavenger::Config.svg_directory)
    end

    def svg_sprite_sheet
      content_tag :svg, compressor.compress_dir.html_safe, style: "display:none;"
    end

    def svg(ref, options = {})
      options[:class] = scavenger_symbol_class(ref) if options[:class].nil?
      content_tag :svg, "<use xlink:href=\"##{scavenger_symbol_ref(ref)}\"/>".html_safe, options
    end

    def scavenger_sprite_path
      asset_path File.basename(Scavenger::Config.sprite_path)
    end

    def scavenger_symbol_class(ref)
      "#{Scavenger::Config.class_prefix}#{ref.gsub('/', '--')}"
    end

    def scavenger_symbol_ref(ref)
      "#{Scavenger::Config.id_prefix}#{ref.gsub('/', '--')}"
    end
  end
end

ActiveSupport.on_load(:action_view) { include Scavenger::ViewHelpers }
