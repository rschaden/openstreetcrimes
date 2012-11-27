require 'parse_feed'

class RawCrimes < ActiveRecord::Base
  attr_accessible :date, :guid, :link, :text, :title

  validates :guid, presence: true, uniqueness: true

  BERLIN_POLIZEI_FEED_URL = "http://www.berlin.de/polizei/presse-fahndung/_rss_presse.xml"

  def location_string
    street = Osc::ParseFeed.street(text)
    district = Osc::ParseFeed.district(title)

    "#{street} #{district} Berlin".strip
  end

  def self.update_from_feed
    feed = Feedzirra::Feed.fetch_and_parse(BERLIN_POLIZEI_FEED_URL)
    feed.entries.each do |entry|
      save_feed_entry entry
    end
  end

  private
    def self.save_feed_entry entry
      unique_id = Digest::SHA1.hexdigest(entry.entry_id)

      html = Net::HTTP.get(URI(entry.url))
      doc = Nokogiri::HTML(html)
      content_node = doc.css("#bomain_content").first rescue Nokogiri::XML::NodeSet.new
      content_node.set_attribute("id", unique_id)

      db_entry = RawCrimes.new(
        guid: unique_id,
        title: entry.title,
        link: entry.url,
        date: entry.published,
        text: content_node.to_html
      )

      title_short = entry.title.length < 60 ? entry.title : "#{entry.title.slice(0,60)}..."
      if db_entry.valid?
        db_entry.save
        puts "Saved: #{title_short}" if db_entry.persisted?
      else
        puts "Already exists: #{title_short}"
      end
    end
end
