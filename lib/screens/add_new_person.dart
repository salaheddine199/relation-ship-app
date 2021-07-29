import 'package:flutter/material.dart';

class AddNewPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adding A New Person',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('hiiiii'),
          ],
        ),
      ),
    );
  }
}
