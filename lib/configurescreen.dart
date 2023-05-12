import 'package:flutter/material.dart';

class ConfigureScreen extends StatefulWidget {
  ConfigureScreen({super.key});
  bool sprinklerState = false;
  @override
  State<ConfigureScreen> createState() => _ConfigureScreenState();
}

class _ConfigureScreenState extends State<ConfigureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configure SPIAR')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Sprinklers'),
            value: widget.sprinklerState,
            onChanged: (e) {
              setState(() {
                widget.sprinklerState = e;
              });
            },
            secondary: const ImageIcon(AssetImage('images/sprinkler_icon.png')),
          ),
          Center(
            child: Wrap(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Force Stop'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
