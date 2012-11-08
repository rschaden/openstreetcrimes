require 'feedzirra'


namespace :osc do
  desc "Fetches Berlin Police feeds"
	task :fetch_feeds do
		feed = Feedzirra::Feed.fetch_and_parse("http://www.berlin.de/polizei/presse-fahndung/_rss_presse.xml")

		# feed and entries accessors
		feed.title          # => "Paul Dix Explains Nothing"
		feed.url            # => "http://www.pauldix.net"
		feed.feed_url       # => "http://feeds.feedburner.com/PaulDixExplainsNothing"
		feed.etag           # => "GunxqnEP4NeYhrqq9TyVKTuDnh0"
		feed.last_modified  # => Sat Jan 31 17:58:16 -0500 2009 # it's a Time object

		puts feed.title


		feed.entries.each do |entry|
      puts entry.title      # => "Ruby Http Client Library Performance"
      puts entry.url        # => "http://www.pauldix.net/2009/01/ruby-http-client-library-performance.html"
		end


	end
end
