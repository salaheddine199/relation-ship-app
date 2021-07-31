import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relation_ships_program/layout/cubit/states.dart';
import 'package:relation_ships_program/models/person_model.dart';
import 'package:relation_ships_program/screens/business_screen.dart';
import 'package:relation_ships_program/screens/family_screen.dart';
import 'package:relation_ships_program/screens/friends_screen.dart';
import 'package:relation_ships_program/shared/cashe_helper.dart';
import 'package:relation_ships_program/shared/components.dart';
import 'package:sqflite/sqflite.dart';

class RelCubit extends Cubit<RelStates>{

  RelCubit() : super(RelInitialState());
  static RelCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;
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
    emit(RelChangeNavBarState());
  }

  void changeDarkMode(){
    bool isDark = CacheHelper.getDarkMode();
    CacheHelper.setDarkMode(darkMode: !isDark).then((value) {

      emit(RelChangeDarkModeState());

    });

  }

  void changeLanguage({required isEnglish}){
    //bool isEnglish = CacheHelper.getLanguage();
    CacheHelper.setLanguage(lang: isEnglish).then((value) {

      emit(RelChangeLanguageState());

    });

  }


    // database work:


  List<Map<String, dynamic>> family =[];
  List<Map<String, dynamic>> friends =[
    // {
    //   "id": 1,
    //   "name": 'salah',
    //   "number": '077356945',
    //   "birthDate": 'setifalgeriahh',
    //   "informationAbout": 'doulove me',
    //   "relation": 'singlebais',
    // },
    // {
    //   "id": 2,
    //   "name": 'kach wahd w 5las',
    //   "number": '05285852',
    //   "birthDate": 'setifalgeriahh',
    //   "informationAbout": 'doulove me',
    //   "relation": 'singlebais',
    // },
  ];
  List<Map<String, dynamic>> business =[];

//List<Map<String, dynamic>> everyOne =[]; // only for now..


  late Database database;

  void createDatabase() async{

    emit(RelGetLoadingCreateDatabase()); // TODO not sure about this


    //then : emit((AppCreateDatabaseState()); // TODO add CreateDB State
    database = await openDatabase(
      'relationships.db',
      version: 1,
      onCreate: (Database db, int version) {
        // when creating the database, create the table
        db.execute(
          'CREATE TABLE person (id INTEGER PRIMARY KEY, name TEXT, number TEXT, birthDate TEXT, informationAbout TEXT, relation TEXT)',
        )
            .then((value) {
              print('table person created');
        })
            .catchError((error) {
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (Database db){
        print('database opened');
        getDataFromDatabase(db); // db NOT database u should know why *-*
        //  لازم نديرو هكا خطرتش db يوجد قبل database
        //  وكون نديرو هذا الأخير يقلك rawQuery called on null
      }
    );
  }


  void insertToDatabase({
  required PersonModel person,
}){
    database.transaction((txn){
      return txn.rawInsert(
        'INSERT INTO person(name, number, birthDate, informationAbout, relation) VALUES(?, ?, ?, ?, ?)',
        [person.name, person.number, person.birthDate, person.informationAbout, person.relation],

      ).then((value) {
        print('$value inserted successfully');

        emit(RelInsertDatabase());
        getDataFromDatabase(database);

      }).catchError((error){
        print('error while inserting : ${error.toString()}');
      });

    });
  }

  void deleteFromDatabase({
  required int? id,
}){
    database.rawDelete(
      'DELETE FROM person WHERE id =?',
      ['$id'],
    ).then((value) {

      if(value!= 0){
        print('$value deleted successfully');
        emit(RelDeleteDatabase());
        getDataFromDatabase(database);

      }
      else{
        print('No person with id = $id !!');
      }

    }).catchError((error){
      print('error when deleting a row : ${error.toString()}');
    });
  }


  void updateRelationFromDatabase({
    required int? id,
    required String newRelation,
  }){
    database.rawUpdate(
      'UPDATE person SET relation = ? WHERE id = ?',
      [newRelation, id],
    ).then((value) {

      if(value!= 0){
        print('$value updated successfully');
        emit(RelUpdateDatabase());
        getDataFromDatabase(database);
      }
      else{
        print('No person with id = $id !!');
      }

    }).catchError((error){
      print('error when updating a row : ${error.toString()}');
    });

  }


  void getDataFromDatabase(Database database){

    emit(RelGetLoadingDatabase());

    database.rawQuery(
      'SELECT * FROM person',
    ).then((value) {

      family.clear();
      friends.clear();
      business.clear();

      // TODO u can parse them to PersonModel b4 adding them, and make those 3 lists List<PersonMode>
      for(Map item in value){
        if(item['relation'] == relationShips[0]) // family
          family.add(item as Map<String, dynamic>);
        else if(item['relation'] == relationShips[1]) // friend
          friends.add(item as Map<String, dynamic>);
        else if(item['relation'] == relationShips[2]) // business
          business.add(item as Map<String, dynamic>);
      }

      print('list of family : $family');
      print('list of friends : $friends');
      print('list of business : $business');

      // everyOne = value;
      // print('list : $everyOne');


      emit(RelGetDatabase());

    }).catchError((error){
      print('error when getting the data from DB: ${error.toString()}');
    });
  }



}