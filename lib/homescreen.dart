import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spiar/admin_alert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng initialCoord = const LatLng(43.925195174024616, 24.6077756590227);
  double defaultZoom = 15;

  late Marker robotMarker;
  late CameraPosition _initCameraPosition;
  late GoogleMapController _googleMapController;
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initCameraPosition = CameraPosition(
      target: initialCoord,
      zoom: defaultZoom,
    );
    robotMarker = Marker(
      markerId: const MarkerId('robot'),
      infoWindow: const InfoWindow(title: 'Robot'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: const LatLng(43.925195174024616, 24.6077756590227),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S.P.I.A.R."),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => AdminAlert());
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: GoogleMap(
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
