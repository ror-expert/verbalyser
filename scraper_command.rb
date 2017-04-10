require_relative "cooljugator-scraper"

fixtures_folder = "spec/fixtures/*"
search_fixtures_folder = Dir[fixtures_folder]

# puts search_fixtures_folder

search_fixtures_folder.each do |item|
  File.readlines(item).each do |verb|
    stripped_verb = verb.strip
    test_run = CooljugatorScraper.new(verb)
    test_run.fetch_page
    test_run.parse_with_nokogiri
    test_run.locate_third_person
  end
end

# verb = ARGV.join(" ")
# test_run = CooljugatorScraper.new(verb)
# test_run.fetch_page
# test_run.parse_with_nokogiri
# test_run.locate_third_person
