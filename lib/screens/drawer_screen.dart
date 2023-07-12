import 'package:flutter/material.dart';
import 'package:relationships/screens/setting_screen.dart';
import 'package:relationships/shared/components.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 25.0,
      semanticLabel: 'myDrawer',
      child: Container(
        color: Theme.of(context).primaryColor.withOpacity(.85),
      child: Column(
          children: [
            Container(
              width: double.infinity,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      child: Icon(
                        Icons.person,
                        size: 65,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'drawer header',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headline3!.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'my profile',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    onTap: () {
                      // showBottomSheet(
                      //   context: context,
                      //   builder: (context) {
                      //     return Container(
                      //       height: 200,
                      //     );
                      //   },
                      // );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'settings',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    onTap: () {
                      navigateTo(context, SettingScreen());
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: Text(
                      'about the application',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(
                      'about us',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
