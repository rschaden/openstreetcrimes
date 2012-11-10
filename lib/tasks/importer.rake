require 'feedzirra'
# require "#{Rails.root}/app/models/raw_crimes"

namespace :osc do
  desc "Fetches Berlin Police feeds"
	task :fetch_feeds => :environment do
		feed = Feedzirra::Feed.fetch_and_parse("http://www.berlin.de/polizei/presse-fahndung/_rss_presse.xml")

		# feed and entries accessors
		feed.title
		feed.url
		feed.feed_url
		feed.etag
		feed.last_modified

		puts feed.title
require 'pry'; binding.pry

		feed.entries.each do |entry|
      db_entry = RawCrimes.new(
        guid: entry.entry_id,
        title: entry.title,
        link: entry.url,
        date: entry.published)

#       db_entry.save if db_entry.valid?
		end


	end
end
