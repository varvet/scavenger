# Scavenger

!(https://img.shields.io/gem/v/scavenger.svg "Version") !(https://img.shields.io/travis/johanhalse/scavenger.svg "Build status")

A Rails plugin for turning a directory of svg images into a bunch of `<symbol>` tags in a sprite sheet and using them by reference. The main advantage of using `<symbol>` is that you can define a viewBox for each element, which means it's possible to reuse and resize them and still make them occupy the space you'd expect them to. A common use case would be icons.


## Getting started

Put the gem in your `Gemfile` and run `bundle install`:
`gem "scavenger"`

Create a folder called `app/assets/svg` and put your svg images there.

Add the following to `views/layouts/application.html.erb`:
`<%= svg_sprite_sheet %>`

Now you can refer to your svg images by their name, so if you have `hejsna.svg` sitting in your svg directory, you can make it show up by writing `<%= svg "hejsna" %>`.


## The `svg` helper

Scavenger works by inserting svg tags with references to ids defined in the sprite sheet. There is nothing inherently special about these svg tags, so if you want to add classes or attributes to them in the usual Rails fashion, you can: `<%= svg "hejsna", class: "foo", style: "width:100px" %>`.


## Loading the sprite sheet asynchronously

Scavenger comes with a dependency-free javascript for fetching and injecting the sprite sheet into the DOM. This is a  good idea since the sprite sheet can be served from your reverse proxy and cached by the browser. Extra useful if you have a lot of symbols and don't want to bloat every page, but the downside is that users may experience a brief flash of missing icons. To use this javascript, remove the `<%= svg_sprite_sheet %>` helper from your layout and instead include the javascript in your `application.js` like so:
`//= require scavenger`


## Configuration

You can configure Scavenger to do your bidding. Create a file called `config/initializers/scavenger.rb` and put your configuration there.


### Use another directory

Default is `app/assets/svg` but it can be changed with the following directive:
`Scavenger::Config.svg_directory = Rails.root.join("app", "assets", "my_directory")`


### Put the compiled sprite sheet somewhere else

Default is `app/assets/images/sprite.svg` but it can be changed with the following directive:
`Scavenger::Config.sprite_path = Rails.root.join("app", "assets", "my_directory", "my_file.svg")`


### Set a default prefix on your svg classes

The svg references will get their name as the default classname, so `hejsna.svg` will be inserted like this: `<svg class="hejsna">`. If you want a prefix, for instance `icon-`, put `Scavenger::Config.class_prefix = "icon-"` in your configuration file and the svg will look like this instead: `<svg class="icon-hejsna">`.


### Change how aspect ratio is preserved

Default is `"xMinYMin meet"` but it can be changed with the following directive:
`Scavenger::Config.aspect_ratio = "xMaxYMax meet"`

A full list of options for this directive can be found [here](https://developer.mozilla.org/en/docs/Web/SVG/Attribute/preserveAspectRatio).


## Caveats

Scavenger uses a basic built-in compressor. It will remove comments, non-significant whitespace, and ids from your files. Since every svg lives as a `symbol` within the sprite sheet, all `<defs>` tags and everything in them will be removed. Tools (like [Sketch](https://www.sketchapp.com)) will sometimes export your files with references inside a `<defs>` tag, and use really generic ids like `path-1`. That poses a problem for us since there's only one global `<defs>` tag within an svg, and ids are global to the html document. We've experimented with some workarounds but nothing satisfactory, so the solution for now is to manually fix any svgs that use `<defs>` tags in this way before placing them in the svg directory.


## Author

I'm [Johan Halse](https://twitter.com/hejsna) and I work for illustrious Swedish developers [Varvet](https://www.varvet.com). You should hire us if you need well-made, quality software!
