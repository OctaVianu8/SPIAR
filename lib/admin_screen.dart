import 'package:flutter/material.dart';

import 'admin_alert.dart';
import 'classes.dart';

// ignore: must_be_immutable
class AdminScreen extends StatefulWidget {
  AdminScreen({super.key});
  bool sprinklerState = false;
  bool cultivatorState = true;
  bool sowerState = false;
  bool generatorOn = true;
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  double distanceTraveled = 5.24; //in km
  double spiarWidth = 3; //in meters

  @override
  Widget build(BuildContext context) {
    List<ListTileStrings> infoTiles = [
      ListTileStrings(
          'Distance traveled', '', '${distanceTraveled.toString()} km'),
      ListTileStrings('Area covered', '',
          '${(distanceTraveled * spiarWidth / 10).toString()} ha'),
      ListTileStrings('Battery remaining (%)', '', '86%'),
      ListTileStrings(
          'Battery autonomy remaining', '(hours, w/o solar panels)', '10.8h'),
      ListTileStrings(
          'Battery autonomy remaining', '(hours, with solar panels)', '12.0h'),
      ListTileStrings('Battery health', '', '100%'),
      ListTileStrings('Average Solar Panels Power Today', '', '10.2 KW'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: ListView(
        children: [
          const ListTile(
            title: Text(
              'INFO',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          ...infoTiles.map(
            (e) => ListTile(
              title: Text(e.title),
              subtitle: e.subtitle != '' ? Text(e.subtitle) : null,
              trailing: Text(e.trailing),
            ),
          ),
          const ListTile(
            title: Text(
              'SETTINGS',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: Text('Sprinklers'),
            value: widget.sprinklerState,
            onChanged: (e) {
              setState(() {
                widget.sprinklerState = e;
              });
            },
            secondary: const ImageIcon(AssetImage('images/sprinkler_icon.png')),
          ),

          SwitchListTile(
            title: const Text('Cultivator'),
            value: widget.cultivatorState,
            onChanged: (e) {
              setState(() {
                widget.cultivatorState = e;
              });
            },
            secondary:
                const ImageIcon(AssetImage('images/cultivator_icon.png')),
          ),
          SwitchListTile(
            title: const Text('Sowers'),
            value: widget.sowerState,
            onChanged: (e) {
              setState(() {
                widget.sowerState = e;
              });
            },
            secondary: const ImageIcon(
              AssetImage('images/sower_icon.png'),
              size: 30,
            ),
          ),
          ListTile(
            leading: const ImageIcon(AssetImage('images/bolt_icon.png')),
            title: Text('Generator'),
            trailing: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    widget.generatorOn
                        ? Colors.green
                        : Colors.grey[800] ?? Colors.red),
              ),
              child: Text(widget.generatorOn ? 'ON' : 'OFF'),
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (context) => AdminAlert(
                    generator: true,
                  ),
                );
                if (result == 1) {
                  setState(() {
                    widget.generatorOn = !widget.generatorOn;
                  });
                } else
                  print('n-a mers');
              },
            ),
          ),
          // Center(
          //   child: Wrap(
          //     children: [
          //       ElevatedButton(
          //         onPressed: () {},
          //         child: const Text('Force Stop'),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
