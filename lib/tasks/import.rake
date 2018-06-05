require 'importable/importer'

namespace :import do
  desc "import from other jekyll"

  task jekyll: :environment do
    fail("set env TARGET_DIR") unless ENV['TARGET_DIR'].present?
    Importable::Importer.import
  end
end
