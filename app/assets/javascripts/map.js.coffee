$(document).ready ->
  Map.initialize()

Map =
  initialize: ->
    districts =  $('#map').data('district')
    center_x =  $('#map').data('center-x')
    center_y =  $('#map').data('center-y')

    map = new OpenLayers.Map 'map'
    map.addLayer(new OpenLayers.Layer.OSM());

    renderer = OpenLayers.Util.getParameters(window.location.href).renderer
    renderer = (if (renderer) then [renderer] else OpenLayers.Layer.Vector::renderers)

    layer_style = @.get_layer_style()
    style_blue = @.get_style("blue", layer_style)

    vectorLayer = new OpenLayers.Layer.Vector("Berlin Districts",  { style: layer_style, renderers: renderer } )
    district_features = @.get_district_features(districts, style_blue)
    vectorLayer.addFeatures(district_features)
    map.addLayer(vectorLayer)

    test_data = @.get_test_data()
    heatmapLayer = new OpenLayers.Layer.Heatmap("Heatmap Layer", map, test_data, {visible: true, radius: 15}, {isBaseLayer: false, opacity: 0.3, projection: new OpenLayers.Projection("EPSG:4326")})
    map.addLayer(heatmapLayer)

    map.setCenter(new OpenLayers.LonLat(center_x, center_y), 10);


  get_layer_style: ->
    layer_style = OpenLayers.Util.extend({}, OpenLayers.Feature.Vector.style['default'])
    layer_style.fillOpacity = 0.3
    layer_style.graphicOpacity = 1
    layer_style

  get_style: (color, layer_style) ->
    style = OpenLayers.Util.extend({}, layer_style)
    style.strokeColor = color
    style.fillColor = color
    style

  get_district_features: (districts, style) ->
    wkt_parser = new OpenLayers.Format.WKT()
    features = []
    for district in districts
      poly = district['area']
      wkt_polygon = wkt_parser.read(poly)
      wkt_polygon.style = style
      features.push wkt_polygon
    features


  get_test_data: ->
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
