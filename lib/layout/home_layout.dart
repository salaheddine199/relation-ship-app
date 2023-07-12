import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relationships/screens/add_new_person.dart';
import 'package:relationships/screens/drawer_screen.dart';
import 'package:relationships/shared/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<RelCubit,RelStates>(
      listener: (context, state){},
      builder: (context, state){
        RelCubit cubit = RelCubit.get(context);
        return Scaffold(
          key: GlobalKey<ScaffoldState>(),
          appBar: AppBar(
            title: Text(
                cubit.titles[cubit.currentIndex],
              style: Theme.of(context).textTheme.caption,
            ),
            actions: [
              IconButton(
                onPressed: (){
                  cubit.changeDarkMode();
                },
                icon: Icon(Icons.nights_stay),
              ),
              IconButton(
                onPressed: (){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.WARNING,
                    animType: AnimType.SCALE,
                    title: 'Warning',
                    //desc: 'I didn\'t implement the search process .............',
                    body: Text(
                      'I did not implement the search process yet    ',
                      textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).textTheme.headline3!.color,
                    ),
                    ),
                    //autoHide: Duration(seconds: 2),
                    //btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                    btnOkIcon: Icons.done_all,
                    btnOkColor: Theme.of(context).primaryColor,
                  )..show();
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          drawer: MyDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, AddNewPerson());

            },
            child: Icon(Icons.add,),
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   items: [
          //     BottomNavigationBarItem(icon: Icon(Icons.family_restroom), label: 'Family',),
          //     BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'Friends',),
          //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Business',),
          //   ],
          //   currentIndex: cubit.currentIndex,
          //   onTap: (int index){
          //     cubit.changeNavBar(index);
          //   },
          // ),
          bottomNavigationBar: ConvexAppBar(
            items: [
              TabItem(icon: Icons.family_restroom, title: 'Family'),
              TabItem(icon: Icons.people_rounded, title: 'Friends'),
              TabItem(icon: Icons.person, title: 'Business'),
            ],
            backgroundColor: Theme.of(context).primaryColor,
            color: Theme.of(context).textTheme.headline3!.color,
            activeColor: Theme.of(context).textTheme.headline3!.color,
            initialActiveIndex: cubit.currentIndex,//optional, default as 0
            onTap: (int i) {
              cubit.changeNavBar(i);
            },
            top: -20.0,
            //  curveSize: 80,
            height: 60.0,
          ),
        );
      },
    );
  }
}
