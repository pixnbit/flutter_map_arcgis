import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_arcgis/flutter_map_arcgis.dart';
import 'package:latlong/latlong.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ArcGIS')),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(32.91081899999999, -92.734876),
                    zoom: 5.0,
                    plugins: [EsriPlugin()],
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                      subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                      tileProvider: CachedNetworkTileProvider(),
                    ),
                    FeatureLayerOptions(
                        url:
                            "https://services.arcgis.com/P3ePLMYs2RVChkJx/arcgis/rest/services/USA_States_Generalized/FeatureServer/0",
                        geometryType: "polygon",
                        onTap: (attributes, LatLng location) {
                          print(attributes);
                        },
                        polygonOptions: PolygonOptions(
                            borderColor: Colors.blueAccent,
                            color: Colors.black12,
                            borderStrokeWidth: 2),
                        polygonOptionsByAttributes: (dynamic attributes) {
                          Color fillColor = Colors.black12;
                          if (attributes is Map<String, dynamic>) {
                            if (attributes['STATE_ABBR'] == 'FL') {
                              fillColor = Colors.red;
                            } else if (attributes['STATE_ABBR'] == 'CA') {
                              fillColor = Colors.purple;
                            } else if (attributes['STATE_ABBR'] == 'OR') {
                              fillColor = Colors.green;
                            } else if (attributes['STATE_ABBR'] == 'NH') {
                              fillColor = Colors.amber;
                            }
                          }
                          return PolygonOptions(
                              borderColor: Colors.black54,
                              color: fillColor,
                              borderStrokeWidth: 2);
                        },
                        onFeatures: (features) {
                          print(features.length);
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
