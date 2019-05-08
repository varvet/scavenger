module Scavenger
  class Compressor
    def initialize(path)
      @path = path
    end

    def allowed_tags
      @allowed_tags ||=
        %w(a altGlyph altGlyphDef altGlyphItem animate animateColor
           animateMotion animateTransform audio canvas circle clipPath
           color-profile cursor discard ellipse feBlend feColorMatrix
           feComponentTransfer feComposite feConvolveMatrix feDiffuseLighting
           feDisplacementMap feDistantLight feDropShadow feFlood feFuncA
           feFuncB feFuncG feFuncR feGaussianBlur feImage feMerge feMergeNode
           feMorphology feOffset fePointLight feSpecularLighting feSpotLight
           feTile feTurbulence filter font font-face font-face-format
           font-face-name font-face-src font-face-uri foreignObject g glyph
           glyphRef hatch hatchpath hkern iframe image line linearGradient
           marker mask mesh meshgradient meshpatch meshrow metadata
           missing-glyph mpath path pattern polygon polyline radialGradient
           rect script set solidcolor stop style svg switch symbol text
           textPath tref tspan unknown use video view vkern)
    end

    def compress_dir
      sheet = Dir.glob(File.join(@path, "**/*.svg"))
                 .select { |f| should_compress? f }
                 .sort
                 .map { |f| f.sub(%r{^#{@path}/?}, "") }
                 .map { |f| compress_file(f) }
                 .join("")

      File.write(Scavenger::Config.sprite_path, "<svg>#{sheet}</svg>") unless Scavenger::Config.sprite_path.nil?
      sheet
    end

    def compress_file(filename)
      id = filename.gsub(%r{/}, "--")
      doc = Nokogiri::XML(File.open(File.join(@path, filename)), &:noblanks)
      doc = doc.remove_namespaces!.root
      remove_comments(doc)
      remove_tags(doc)
      remove_ids(doc)
      symbolize(doc, id)
      doc.to_html
    end

    private

    def should_compress?(filename)
      !File.directory?(filename) &&
        !File.basename(filename).start_with?(".")
    end

    def remove_comments(doc)
      doc.xpath("//comment()").remove
    end

    def remove_tags(doc)
      doc.xpath("//*").each do |node|
        node.remove unless allowed_tags.include?(node.name)
      end
    end

    def remove_ids(doc)
      doc.xpath("//@id").remove
    end

    def symbolize(doc, id)
      doc.xpath("@*").each do |attribute|
        attribute.remove unless attribute.name == "viewBox"
      end
      doc.name = "symbol"
      doc["id"] = Scavenger::Config.id_prefix + id.chomp(".svg")
      doc["preserveAspectRatio"] = Scavenger::Config.aspect_ratio
    end
  end
end
