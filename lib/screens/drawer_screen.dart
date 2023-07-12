import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:relation_ships_program/layout/cubit/cubit.dart';
import 'package:relation_ships_program/layout/cubit/states.dart';
import 'package:relation_ships_program/screens/setting_screen.dart';
import 'package:relation_ships_program/shared/cashe_helper.dart';
import 'package:relation_ships_program/shared/components.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelCubit,RelStates>(
      listener: (context, state){
        if(state is RelChangeDarkModeState){

        }
      },
      builder: (context, state){
        RelCubit cubit = RelCubit.get(context);
        bool value = CacheHelper.getDarkMode();
        return Drawer(
          elevation: 25.0,
          semanticLabel: 'myDrawer',
          child: Container(
            color: Theme.of(context).primaryColor.withOpacity(.85),
            child: Column (
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
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Dark Mode',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            FlutterSwitch(
                              activeColor: Theme.of(context).primaryColor,
                              height: 30.0,
                              width: 65.0,
                              value: value,
                              onToggle: (bool val){
                                cubit.changeDarkMode();
                              },
                              activeIcon: Icon(
                                Icons.nights_stay,
                                color: Colors.black,
                              ),
                              inactiveIcon: Icon(Icons.wb_sunny),
                            ),
                            SizedBox(width: 10,),
                          ],
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Language',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            DropdownButton<String>(
                              hint: Text(
                                '${CacheHelper.getLanguage()? 'English':'Arabic'}',
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.headline3!.color!.withOpacity(.7),
                                  fontSize: 12,
                                ),
                              ),
                              items: <String>[
                                'Arabic',
                                'English',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                if(value == 'Arabic')
                                  cubit.changeLanguage(isEnglish: false);
                                else cubit.changeLanguage(isEnglish: true);
                              },
                            ),
                            SizedBox(width: 10,),
                          ],
                        ),
                        onTap: () {},
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
      },
    );
  }
}
