$(document).ready ->
  Map.initialize()

Map =
  initialize: ->
    districts =  $('#districts').data('district')
    center_x =  $('#districts').data('center-x')
    center_y =  $('#districts').data('center-y')

    map = new OpenLayers.Map 'map'
    map.addLayer(new OpenLayers.Layer.OSM());

    renderer = OpenLayers.Util.getParameters(window.location.href).renderer
    renderer = (if (renderer) then [renderer] else OpenLayers.Layer.Vector::renderers)

    layer_style = OpenLayers.Util.extend({}, OpenLayers.Feature.Vector.style['default'])
    layer_style.fillOpacity = 0.3
    layer_style.graphicOpacity = 1

    style_blue = OpenLayers.Util.extend({}, layer_style)
    style_blue.strokeColor = "blue"
    style_blue.fillColor = "blue"
    style_blue.graphicName = "star"
    style_blue.pointRadius = 10
    style_blue.strokeWidth = 1
    style_blue.rotation = 45
    style_blue.strokeLinecap = "butt"

    vectorLayer = new OpenLayers.Layer.Vector("Berlin Districts",  { style: layer_style, renderers: renderer } )

    wkt_parser = new OpenLayers.Format.WKT()

    for district in districts
      poly = district['area']
      wkt_polygon = wkt_parser.read(poly)
      wkt_polygon.style = style_blue
      vectorLayer.addFeatures([wkt_polygon])

    map.addLayer(vectorLayer)

    testData =
      max: 50,
      data: []

    i = 0

    while i < 500
      lon = Math.random() * 0.7 + 13.110836
      lat = Math.random() * 0.3 + 52.343206
      c = Math.floor(Math.random() * 50)
      testData.data.push
        lonlat: new OpenLayers.LonLat(lon, lat)
        count: c
      i++

    heatmapLayer = new OpenLayers.Layer.Heatmap("Heatmap Layer", map, testData, {visible: true, radius: 10}, {isBaseLayer: false, opacity: 0.3, projection: new OpenLayers.Projection("EPSG:4326")})

    map.addLayer(heatmapLayer)
    map.setCenter(new OpenLayers.LonLat(center_x, center_y), 10);
