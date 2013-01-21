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
    style_blue = @.get_style("#0000ff", layer_style)

    vectorLayer = new OpenLayers.Layer.Vector("Berlin Districts",  { style: layer_style, renderers: renderer } )

    district_features = @.get_district_features(districts, layer_style)
    vectorLayer.addFeatures(district_features)
    map.addLayer(vectorLayer)

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

  get_district_features: (districts, layer_style) ->
    wkt_parser = new OpenLayers.Format.WKT()
    features = []
    colors = ['#ff0000', '#ffa500', '#ffff00', '#00ff00']

    for district in districts
      poly = district['area']
      wkt_polygon = wkt_parser.read(poly)
      color = colors[Math.floor(Math.random()*colors.length)]
      style = @.get_style(color, layer_style)
      wkt_polygon.style = style
      features.push wkt_polygon
    features

