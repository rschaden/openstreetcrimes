require 'parse_feed'
require 'geocode'

class RawCrime < ActiveRecord::Base
  attr_accessible :date, :guid, :link, :text, :title

  validates :guid, presence: true, uniqueness: true

  BERLIN_POLIZEI_FEED_URL = "http://www.berlin.de/polizei/presse-fahndung/_rss_presse.xml"

  scope :converted, where(converted: true)
  scope :unconverted, where(converted: false)

  def location
    Osc::Geocode.raw_crime(self)
  end

  def district
    return nil unless location
    districts = District.all
    districts.select{ |district| district.area.contains? location }.first
  end

  def self.update_from_feed
    feed = Feedzirra::Feed.fetch_and_parse(BERLIN_POLIZEI_FEED_URL)
    feed.entries.each do |entry|
      save_feed_entry entry
    end
  end

  def short_title
    title.length < 60 ? title : "#{title.slice(0,60)}..."
  end

  private
    def self.save_feed_entry entry
      unique_id = Digest::SHA1.hexdigest(entry.entry_id)

      html = Net::HTTP.get(URI(entry.url))
      doc = Nokogiri::HTML(html)
      content_node = doc.css("#bomain_content").first rescue Nokogiri::XML::NodeSet.new
      content_node.set_attribute("id", unique_id)

      db_entry = RawCrime.new(
        guid: unique_id,
        title: entry.title,
        link: entry.url,
        date: entry.published,
        text: content_node.to_html
      )

      if db_entry.valid?
        db_entry.save
        puts "Saved: #{db_entry.short_title}" if db_entry.persisted?
      else
        puts "Already exists: #{db_entry.short_title}"
      end
    end
end
