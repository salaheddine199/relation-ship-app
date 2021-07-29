import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
