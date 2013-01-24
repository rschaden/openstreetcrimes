$(document).ready ->
  DistrictMap.initialize()
  $('button').click -> MapControls.toggle_district_layer()

DistrictMap =
  map: undefined
  district_layer: undefined

  initialize: ->
    @.map = new OpenLayers.Map 'map'
    @.map.addLayer(new OpenLayers.Layer.OSM());

    @.add_district_layer()

    center_x =  $('#map').data('center-x')
    center_y =  $('#map').data('center-y')
    @.map.setCenter(new OpenLayers.LonLat(center_x, center_y), 10);


  add_district_layer: ->
    @.district_layer = new OpenLayers.Layer.Vector("Berlin Districts",
      { style: MapStyle.layer_style(),
      renderers: MapStyle.renderer() } ) unless @.district_layer
    @.district_layer.removeAllFeatures()
    @.district_layer.addFeatures(MapData.district_features())
    @.map.addLayer(@.district_layer)
    MapControls.update_legend()

MapData =
  weighted: false
  district_features: ->
    districts =  $('#map').data('district')
    relevant_count = (if (@.weighted) then 'weighted_count' else 'count')

    wkt_parser = new OpenLayers.Format.WKT()
    features = []

    for district in districts
      style = MapStyle.style(@.district_color(district[relevant_count]))
      wkt_polygon = wkt_parser.read(district['area'])
      wkt_polygon.style = style
      features.push wkt_polygon
    features

  district_color: (count) ->
    colors =  $('#map').data('colors')
    i = 0
    for quantil in @.quantils()
      if count <= quantil
        break
      i++
    colors[i]

  quantils: ->
    if @.weighted
      return $('#map').data('quantils')['weighted']
    else
      return $('#map').data('quantils')['normal']

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

MapControls =
  toggle_district_layer: ->
    button = $('#button')
    if button.text() == "Change to Weighted"
      MapData.weighted = true
      button.text('Change to Normal')
    else
      MapData.weighted = false
      button.text('Change to Weighted')
    DistrictMap.add_district_layer()

  update_legend: ->
    i = 0
    quantils = MapData.quantils()
    for quantil in quantils
      $("#quantil#{i}").text("<=#{quantil}")
      i++
    $("#quantil3").text("> #{quantils[2]}")
