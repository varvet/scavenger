require "test_helper"

class ScavengerTest < ActiveSupport::TestCase
  def setup
    @compressor = Scavenger::Compressor.new("./test/svg")
  end

  def test_has_version_number
    refute_nil ::Scavenger::VERSION
  end

  def test_can_compress_directory
    expected_output  = "<symbol viewBox=\"0 0 173 173\" id=\"hejsna\" preserveAspectRatio=\"xMinYMin meet\"><g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\"><g transform=\"translate(1.000000, 1.000000)\"><circle stroke=\"#979797\" fill=\"#D8D8D8\" cx=\"85.5\" cy=\"85.5\" r=\"85.5\"></circle><path d=\"M83.5,117.5 L83.5,51.5\" stroke=\"#A80C0C\" stroke-linecap=\"square\" fill=\"#A80C0C\"></path><path d=\"M83.5,51.5 L80.5,62.3 L86.5,62.3 L83.5,51.5 Z\" stroke=\"#A80C0C\" stroke-linecap=\"square\" fill=\"#A80C0C\"></path><polygon stroke=\"#979797\" fill=\"#D8D8D8\" points=\"39 92 20.1908719 101.888544 23.7830957 80.9442719 8.56619148 66.1114562 29.595436 63.0557281 39 44 48.404564 63.0557281 69.4338085 66.1114562 54.2169043 80.9442719 57.8091281 101.888544\"></polygon><polygon fill=\"#EB8D8D\" points=\"125 56 154 114 96 114\"></polygon></g></g></symbol>"
    expected_output += "<symbol viewBox=\"0 0 185 69\" id=\"thing\" preserveAspectRatio=\"xMinYMin meet\"><g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\"><g><use stroke=\"#979797\" mask=\"url(#mask-2)\" stroke-width=\"2\" fill=\"#D8D8D8\" href=\"#path-1\"></use><path d=\"M1.5,0.5 L179.5,64.5\" stroke=\"#979797\" stroke-linecap=\"square\"></path><path d=\"M180.5,4.5 L8.5,64.5\" stroke=\"#979797\" stroke-linecap=\"square\"></path><g fill-opacity=\"1\" fill=\"#FFFFFF\"><use filter=\"url(#filter-4)\" href=\"#text-3\"></use><use href=\"#text-3\"></use></g></g></g></symbol>"
    assert_equal expected_output, @compressor.compress_dir
  end

  def test_can_compress_file
    expected_output = "<symbol viewBox=\"0 0 173 173\" id=\"hejsna\" preserveAspectRatio=\"xMinYMin meet\"><g stroke=\"none\" stroke-width=\"1\" fill=\"none\" fill-rule=\"evenodd\"><g transform=\"translate(1.000000, 1.000000)\"><circle stroke=\"#979797\" fill=\"#D8D8D8\" cx=\"85.5\" cy=\"85.5\" r=\"85.5\"></circle><path d=\"M83.5,117.5 L83.5,51.5\" stroke=\"#A80C0C\" stroke-linecap=\"square\" fill=\"#A80C0C\"></path><path d=\"M83.5,51.5 L80.5,62.3 L86.5,62.3 L83.5,51.5 Z\" stroke=\"#A80C0C\" stroke-linecap=\"square\" fill=\"#A80C0C\"></path><polygon stroke=\"#979797\" fill=\"#D8D8D8\" points=\"39 92 20.1908719 101.888544 23.7830957 80.9442719 8.56619148 66.1114562 29.595436 63.0557281 39 44 48.404564 63.0557281 69.4338085 66.1114562 54.2169043 80.9442719 57.8091281 101.888544\"></polygon><polygon fill=\"#EB8D8D\" points=\"125 56 154 114 96 114\"></polygon></g></g></symbol>"
    assert_equal expected_output, @compressor.compress_file("./test/svg/hejsna.svg", "hejsna.svg")
  end
end
