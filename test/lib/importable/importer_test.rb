require 'test_helper'
require "importable/importer"

class Importable::ImporterTest < ActiveSupport::TestCase
  test "truth" do
    site = sites(:one)
    ENV['TARGET_DIR'] = File.join(fixture_path, 'files', 'jekyll')
    assert Importable::Importer.import(site), ''
  end
end
