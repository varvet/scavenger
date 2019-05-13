require "test_helper"

class DummyIntegrationTest < ActionDispatch::IntegrationTest
  def test_svg_helper_and_sheet
    visit("/")
    assert page.has_css?("svg symbol#hejsna")
    assert page.has_css?("svg.hejsna")
    assert page.has_css?("svg symbol#things--thing")
    assert page.has_css?("svg.things--thing")
  end

  def test_prefix
    Scavenger::Config.class_prefix = "icon-"
    visit("/")
    assert page.has_selector?("svg.icon-hejsna")
    Scavenger::Config.class_prefix = nil
  end

  def test_default_aspect_ratio
    visit("/")
    assert page.has_css?("#hejsna[preserveaspectratio='xMinYMin meet']")
  end

  def test_configured_aspect_ratio
    Scavenger::Config.aspect_ratio = "xMaxYMax meet"
    visit("/")
    assert page.has_css?("#hejsna[preserveaspectratio='xMaxYMax meet']")
    Scavenger::Config.aspect_ratio = "xMinYMin meet"
  end
end
