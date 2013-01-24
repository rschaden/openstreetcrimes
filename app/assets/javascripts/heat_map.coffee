$(document).ready ->
  OsmHeatMap.initialize()

OsmHeatMap =
  map: undefined
  initialize: ->
    @.map = new OpenLayers.Map 'map'
    @.map.addLayer(new OpenLayers.Layer.OSM());

    @.add_district_layer()
    @.add_heatmap_layer()

    center_x =  $('#map').data('center-x')
    center_y =  $('#map').data('center-y')
    @.map.setCenter(new OpenLayers.LonLat(center_x, center_y), 10);


  add_district_layer: ->
    vectorLayer = new OpenLayers.Layer.Vector("Berlin Districts",  { style: MapStyle.layer_style(), renderers: MapStyle.renderer() } )
    vectorLayer.addFeatures(MapData.district_features())
    @.map.addLayer(vectorLayer)

  add_heatmap_layer: ->
    test_data = MapData.test_data()
    heatmapLayer = new OpenLayers.Layer.Heatmap("Heatmap Layer", @.map, test_data, {visible: true, radius: 15}, {isBaseLayer: false, opacity: 0.3, projection: new OpenLayers.Projection("EPSG:4326")})
    @.map.addLayer(heatmapLayer)

MapData =
  district_features: ->
    districts =  $('#map').data('district')
    wkt_parser = new OpenLayers.Format.WKT()
    features = []
    for district in districts
      poly = district['area']
      wkt_polygon = wkt_parser.read(poly)
      wkt_polygon.style = MapStyle.style('#0000ff')
      features.push wkt_polygon
    features

  test_data: ->
    test_data =
      max: 50,
      data: []
    i = 0
    while i < 500
      lon = Math.random() * 0.7 + 13.110836
      lat = Math.random() * 0.3 + 52.343206
      c = Math.floor(Math.random() * 50)
      test_data.data.push
        lonlat: new OpenLayers.LonLat(lon, lat)
        count: c
      i++
    test_data

MapStyle =
  renderer: ->
    renderer = OpenLayers.Util.getParameters(window.location.href).renderer
    renderer = (if (renderer) then [renderer] else OpenLayers.Layer.Vector::renderers)

  layer_style: ->
    layer_style = OpenLayers.Util.extend({}, OpenLayers.Feature.Vector.style['default'])
    layer_style.fillOpacity = 0.3
    layer_style.graphicOpacity = 1
    layer_style

  style: (color) ->
    style = OpenLayers.Util.extend({}, @.layer_style())
    style.strokeColor = color
    style.fillColor = color
    style
