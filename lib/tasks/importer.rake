require 'feedzirra'
# require "#{Rails.root}/app/models/raw_crimes"

namespace :osc do
  desc "Fetches Berlin Police feeds"
  task :fetch_feeds => :environment do
    RawCrime.update_from_feed
  end
end
