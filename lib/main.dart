import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relation_ships_program/layout/cubit/cubit.dart';
import 'package:relation_ships_program/layout/home_layout.dart';
import 'package:relation_ships_program/shared/bloc_observer.dart';
import 'package:relation_ships_program/shared/sharedPref_helper.dart';
import 'package:relation_ships_program/shared/colors.dart';

import 'layout/cubit/states.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RelCubit()..createDatabase(),
      child: BlocConsumer<RelCubit,RelStates>(
        listener: (context, state){
          // if(state is RelDeleteDatabase){ // ياه نعرف ادا نقدر نديرها في اي بلاصة نحب ول
          //   print(' raaaaaaaaaaaak drt deleeeeeeeeeeete');
          // }
        },
        builder: (context, state){

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Relationships app',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              primaryColor: MyColors.bgLightColor,
              cardColor: MyColors.bgLightColor,
              scaffoldBackgroundColor: MyColors.bgLightColor,
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: MyColors.bgLightColor,
                  ),
                  elevation: 25.0,
                  backgroundColor: MyColors.bgLightColor,
                  titleSpacing: 20.0,
                  titleTextStyle: TextStyle(
                    color: MyColors.blackColor,
                  ),
                  iconTheme: IconThemeData(
                    color: MyColors.blackColor,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Color(0xffaabbff),
                  elevation: 25.0,
                  selectedItemColor: MyColors.blackColor,
                  unselectedItemColor: MyColors.blackColor.withOpacity(.5),
                ),
              textTheme: TextTheme(
                caption: TextStyle(
                  color: MyColors.blackColor,
                  fontSize: 18,
                ),
                headline3: TextStyle(
                  color: MyColors.blackColor,
                  fontSize: 16,
                ),
                headline2: TextStyle(
                  color: MyColors.blackColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),



            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              primaryColor: MyColors.bgDarkColor,
              cardColor: MyColors.bgDarkColor,
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Color(0xFF4B3B33),
                ),
                elevation: 25.0,
                backgroundColor: Color(0xFF4B3B33),
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                  color: MyColors.whiteColor,
                ),

              ),
              scaffoldBackgroundColor: MyColors.bgDarkColor.withOpacity(.9),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: MyColors.bgDarkColor,
                elevation: 25.0,
                selectedItemColor: MyColors.whiteColor,
                unselectedItemColor: MyColors.whiteColor.withOpacity(.5),
              ),
              iconTheme: IconThemeData(
                color: MyColors.whiteColor,
              ),
              textTheme: TextTheme(
                caption: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 18,
                ),
                headline3: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 16,
                ),
                headline2: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            themeMode: CacheHelper.getDarkMode()
                ?ThemeMode.dark
                :ThemeMode.light,

            // here we test if this is the first time so set it 3la system
            // else choose what he'll choose later
            // themeMode: _isFrst
            //     ? ThemeMode.system
            //     : CacheHelper.getDarkMode()
            //       ?ThemeMode.dark
            //       :ThemeMode.light,


            home: HomeLayout(),
          );
        },
      ),
    );
  }
}
