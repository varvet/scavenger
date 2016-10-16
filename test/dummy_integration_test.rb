require "test_helper"

class DummyIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    Scavenger::Config.class_prefix = nil
  end

  def test_svg_helper_and_sheet
    visit("/")
    assert page.has_css?("svg symbol#hejsna")
    assert page.has_css?("svg.hejsna")
  end

  def test_prefix
    Scavenger::Config.class_prefix = "icon-"
    visit("/")
    assert page.has_selector?("svg.icon-hejsna")
  end
end
