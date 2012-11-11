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

		feed.entries.each do |entry|

      unique_id = Digest::SHA1.hexdigest(entry.entry_id)

      html = Net::HTTP.get(URI(entry.url))
      doc = Nokogiri::HTML(html)
      content_node = doc.css("#bomain_content").first rescue Nokogiri::NodeSet.new
      content_node.attr("id", unique_id)

      db_entry = RawCrimes.new(
        guid: unique_id,
        title: entry.title,
        link: entry.url,
        date: entry.published,
        text: content_node.to_html
      )
       if RawCrimes.find(guid: unique_id).count == 0
          db_entry.save if db_entry.valid?
          puts "Saved: #{entry.title}" if db_entry.persisted?
       end
		end


	end
end
