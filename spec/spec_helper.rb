require "bundler/setup"
require "verbalyser"
require "verbalyser/cooljugator_fetcher"
require "verbalyser/verb_shortlister"
require "verbalyser/conjugation_scraper"
require "verbalyser/lemma_matcher"
require "verbalyser/endings_grouper"
require "verbalyser/flashcard_maker"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
