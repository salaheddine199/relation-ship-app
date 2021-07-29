import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relation_ships_program/layout/cubit/states.dart';
import 'package:relation_ships_program/screens/business_screen.dart';
import 'package:relation_ships_program/screens/family_screen.dart';
import 'package:relation_ships_program/screens/friends_screen.dart';
import 'package:relation_ships_program/shared/cashe_helper.dart';

class RelCubit extends Cubit<RelStates>{

  RelCubit() : super(RelInitialState());
  static RelCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens =[
    FamilyScreen(),
    FriendsScreen(),
    BusinessScreen(),
  ];
  List<String> titles =[
    'Family Section',
    'Friends Section',
    'Business Section',
  ];
  void changeNavBar(index){
    currentIndex = index;
    emit(RelChangeNavBartate());
  }

  void changeDarkMode(){
    bool isDark = CacheHelper.getDarkMode();
    CacheHelper.setDarkMode(darkMode: !isDark).then((value) {

      emit(RelChangeDarkModeState());

    });

  }


  // database:

  List<Map<String, dynamic>> family =[];
  List<Map<String, dynamic>> friends =[
    {
      "id": 1,
      "name": 'salah',
      "number": '077356945',
      "birthDate": 'setifalgeriahh',
      "informationAbout": 'doulove me',
      "relation": 'singlebais',
    },
    {
      "id": 2,
      "name": 'kach wahd w 5las',
      "number": '05285852',
      "birthDate": 'setifalgeriahh',
      "informationAbout": 'doulove me',
      "relation": 'singlebais',
    },
  ];
  List<Map<String, dynamic>> business =[];




}