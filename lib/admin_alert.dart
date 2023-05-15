import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminAlert extends StatefulWidget {
  AdminAlert({required this.generator, super.key});
  bool generator;
  @override
  State<AdminAlert> createState() => _AdminAlertState();
}

class _AdminAlertState extends State<AdminAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Alert'),
      content: Text(widget.generator
          ? 'Are you sure you want to toggle the generator?'
          : 'You need administrator priviliges to access the configure tab.'),
      actions: [
        TextButton(
          child: const Text('Enter'),
          onPressed: () {
            Navigator.pop(context, 1);
            if (!widget.generator) Navigator.pushNamed(context, '/admin');
          },
        ),
      ],
    );
  }
}
