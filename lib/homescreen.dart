import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spiar/admin_alert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng initialCoord = const LatLng(43.925195174024616, 24.6077556590227);
  double defaultZoom = 15;

  late Marker robotMarker;
  late CameraPosition _initCameraPosition;
  late GoogleMapController _googleMapController;
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  List<double> saltX = [
    -0.00450701439,
    -0.00003681722,
    0.00449506533,
    -0.00001917849
  ];
  List<double> saltY = [
    0.00129770066,
    -0.00015359409,
    -0.00130676069,
    -0.00015312481
  ];
  double startX = 43.92605606873217;
  double startY = 24.60903142773457;
  Set<Polyline> _polyline = {};
  List<LatLng> latLen = [];
  bool showPolyline = true;
  bool showPolygon = true;

  @override
  void initState() {
    //set polylines
    double currX = startX, currY = startY;
    for (int i = 0; i < 19; i++) {
      latLen.add(LatLng(currX, currY));
      currX += saltX[i % 4];
      currY += saltY[i % 4];
    }
    latLen.add(initialCoord);

    for (int i = 0; i < latLen.length; i++) {
      _polyline.add(Polyline(
        width: 4,
        polylineId: PolylineId(i.toString()),
        points: latLen,
        color: Colors.green,
      ));
    }
    _initCameraPosition = CameraPosition(
      target: initialCoord,
      zoom: defaultZoom,
    );
    robotMarker = Marker(
      markerId: const MarkerId('robot'),
      infoWindow: const InfoWindow(title: 'S.P.I.A.R.'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: const LatLng(43.925195174024616, 24.6077756590227),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S.P.I.A.R. Map"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 0,
                enabled: true,
                child: Text("Show today's crossed path"),
              ),
              PopupMenuItem(
                value: 1,
                child: Text("Show designated area"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Admin panel"),
              ),
            ],
            onSelected: (value) {
              if (value == 0) {
                setState(() {
                  showPolyline = !showPolyline;
                });
              }
              if (value == 1) {
                setState(() {
                  showPolygon = !showPolygon;
                });
              }
              if (value == 2) {
                showDialog(
                    context: context, builder: (context) => const AdminAlert());
              }
            },
          ),
        ],
      ),
      body: GoogleMap(
        polygons: showPolygon
            ? {
                Polygon(
                    polygonId: const PolygonId("1"),
                    fillColor: Colors.yellow.withOpacity(0.2),
                    strokeWidth: 2,
                    strokeColor: Colors.yellow.withOpacity(0.7),
                    points: const [
                      LatLng(43.926179372152056, 24.609155652597998),
                      LatLng(43.92146674268428, 24.61042464704549),
                      LatLng(43.915847261225274, 24.588655371012596),
                      LatLng(43.920584314210004, 24.586320358599945),
                    ]),
              }
            : {},
        polylines: showPolyline ? _polyline : {},
        markers: {robotMarker},
        zoomControlsEnabled: false,
        onMapCreated: (controller) => _googleMapController = controller,
        mapType: MapType.satellite,
        initialCameraPosition: _initCameraPosition,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(_initCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
