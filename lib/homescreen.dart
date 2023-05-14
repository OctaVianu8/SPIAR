import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spiar/admin_alert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng initialCoord = const LatLng(43.925195174024616, 24.6077956590227);
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
    -0.00450561439,
    -0.00003681722,
    0.00449506533,
    -0.00001917849
  ];
  List<double> saltY = [
    0.00130659066,
    -0.00015359409,
    -0.00130676069,
    -0.00015312481
  ];
  double startX = 43.92605606873217;
  double startY = 24.60903142773457;
  Set<Polyline> _polyline = {};
  List<LatLng> latLen = [];

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
                child: Text("Show today's crossed path"),
              ),
              PopupMenuItem(
                value: 1,
                child: Text("Show designated area"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Admin settings"),
              ),
            ],
            onSelected: (value) {
              if (value == 2) {
                showDialog(
                    context: context, builder: (context) => const AdminAlert());
              }
            },
          ),
        ],
      ),
      body: GoogleMap(
        polylines: _polyline,
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
