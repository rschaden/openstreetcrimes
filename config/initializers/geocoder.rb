Geocoder.configure(
  lookup: :nominatim,

  cache: Redis.new
)
