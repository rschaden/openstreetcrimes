$(document).ready ->
  Map.initialize()
  $('button').click -> Map.toggle_district_layer()

Map =
  map: undefined
  district_layer: undefined
  initialize: (weighted = false) ->
    center_x =  $('#map').data('center-x')
    center_y =  $('#map').data('center-y')

    @.map = new OpenLayers.Map 'map'
    @.map.addLayer(new OpenLayers.Layer.OSM());

    @.district_layer = new OpenLayers.Layer.Vector("Berlin Districts",  { style: @.layer_style, renderers: @.renderer() } )

    district_features = @.district_features(weighted)
    @.district_layer.addFeatures(district_features)
    @.map.addLayer(@.district_layer)

    @.map.setCenter(new OpenLayers.LonLat(center_x, center_y), 10);

  toggle_district_layer: ->
    @.district_layer.removeAllFeatures()
    button = $('#button')
    if button.text() == "Change to Weighted"
      district_features = @.district_features(true)
      button.text('Change to Normal')
    else
      button.text('Change to Weighted')
      district_features = @.district_features(false)

    @district_layer.addFeatures(district_features)
    @.district_layer.redraw()

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

  district_features: (weighted) ->
    districts =  $('#map').data('district')
    if weighted
      quantils = $('#map').data('quantils')['weighted']
      relevant_count = 'weighted_count'
    else
      quantils = $('#map').data('quantils')['normal']
      relevant_count = 'count'
    colors =  $('#map').data('colors')

    wkt_parser = new OpenLayers.Format.WKT()
    features = []

    for district in districts
      wkt_polygon = wkt_parser.read(district['area'])

      i = 0
      for quantil in quantils
        if district[relevant_count] <= quantil
          break
        i++

      color = colors[i]
      style = @.style(color)
      wkt_polygon.style = style
      features.push wkt_polygon
      @.update_legend(quantils)
    features

  update_legend: (quantils) ->
    i = 0
    for quantil in quantils
      $("#quantil#{i}").text("<=#{quantil}")
      i++
    $("#quantil3").text("> #{quantils[2]}")


