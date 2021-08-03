import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:relation_ships_program/layout/cubit/cubit.dart';
import 'package:relation_ships_program/models/person_model.dart';

List<String> relationShips =[
  'family',
  'friend',
  'business',
];

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

Widget myTestFormField({
  @required TextEditingController controller,
  @required String label,
  @required Function validator,
  @required BuildContext context,
  Icon icon,
  Function onTap,
  bool readOnly = false,
  bool obscureText = false,
  TextInputType keyboard = TextInputType.text,
  double padding = 16,
  int max = 1,
}){
  return TextFormField(

    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(padding),
      prefixIcon: icon,
      labelText: label,
      labelStyle: TextStyle(
        color: Theme.of(context).textTheme.headline3.color.withOpacity(.7),
      ),
      //enabledBorder: OutlineInputBorder(),
      border: OutlineInputBorder(),
    ),
    style: TextStyle(
      color: Theme.of(context).textTheme.headline3.color.withOpacity(.7),
    ),
    maxLines: max,
    validator: validator,
    onTap: onTap,
    controller: controller,
    keyboardType: keyboard,
    readOnly: readOnly,
    obscureText: obscureText,
  );
}

Widget buildOurPersonItem(context, list, String relation){

  // Friend Family Business
  List<String> relations ;//=['',''];
  if(relation == 'Family')
    relations = ['friend','business'];
  else if(relation == 'Friend')
    relations = ['family','business'];
  else
    relations = ['family','friend'];

  return Conditional.single(
      context: context,
      conditionBuilder: (context) => list.length>0,
      widgetBuilder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index)=> Dismissible(
            key: Key( '${PersonModel.fromJson(list[index]).id}' ),
            onDismissed: (DismissDirection direction){
              RelCubit.get(context).deleteFromDatabase(id: PersonModel.fromJson(list[index]).id);
            },
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              height: 100,
              child: Card(
                //clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 25.0,
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Text(
                          '${PersonModel.fromJson(list[index]).id}',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline3.color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(child: Container(
                        height: 55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                '${PersonModel.fromJson(list[index]).name}',
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.headline3.color,
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${PersonModel.fromJson(list[index]).number}',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline3.color.withOpacity(.7),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),),
                      // we're gonna delete when dismiss the item
                      PopupMenuButton(
                        color: Colors.white,
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context){
                          //return ourPopMenuItem(relation);
                          return [
                            PopupMenuItem(
                              value: 'more',
                              child: Text('more'),
                            ),
                            /*
                            PopupMenuItem(
                              value: 'family',
                              child: Text('make them family'),
                            ),
                            PopupMenuItem(
                              value: 'friend',
                              child: Text('make them friend'),
                            ),
                            PopupMenuItem(
                              value: 'business',
                              child: Text('make them business'),
                            ),
                            */

                            PopupMenuItem(
                              value: '${relations[0]}',
                              child: Text('-> ${relations[0]}'),
                            ),
                            PopupMenuItem(
                              value: '${relations[1]}',
                              child: Text('-> ${relations[1]}'),
                            ),

                          ];
                        },
                        //padding: EdgeInsets.only(left: 0),
                        onCanceled: (){
                          print('chooose awdi lah');
                        },
                        onSelected: (String value){
                          if (value == 'more') {

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'This feature is not implemented yet',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );

                          }
                          else if (value == 'family') {
                            RelCubit.get(context).updateRelationFromDatabase(
                              id: PersonModel.fromJson(list[index]).id,
                              newRelation: relationShips[0],
                            );
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text(
                            //       'This person is your family now',
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //         fontSize: 15,
                            //       ),
                            //     ),
                            //   ),
                            // );
                          }
                          else if (value == 'friend') {
                            RelCubit.get(context).updateRelationFromDatabase(
                              id: PersonModel.fromJson(list[index]).id,
                              newRelation: relationShips[1],
                            );
                          }
                          else if (value == 'business') {
                            RelCubit.get(context).updateRelationFromDatabase(
                              id: PersonModel.fromJson(list[index]).id,
                              newRelation: relationShips[2],
                            );
                          }
                        },
                      ),
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.delete_forever_rounded,
                      //     color: Colors.red,
                      //     size: 28,
                      //   ),
                      //   onPressed: (){
                      //     RelCubit.get(context).deleteFromDatabase(id: PersonModel.fromJson(list[index]).id);
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ) ,
          separatorBuilder: (context, index) => Divider(),
          itemCount: list.length,
        ),
      ),
      fallbackBuilder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.family_restroom,
              size: 70,
              color: Theme.of(context).accentColor.withOpacity(.6),
            ),
            SizedBox(height: 20,),
            Text(
              'No $relation Persons here',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
  );

  /*return ConditionalBuilder(
    condition: list.length>0,
    builder: (context)=> Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated
        (
        itemBuilder: (context, index)=> Dismissible(
          key: Key( '${PersonModel.fromJson(list[index]).id}' ),
          onDismissed: (DismissDirection direction){
            RelCubit.get(context).deleteFromDatabase(id: PersonModel.fromJson(list[index]).id);
          },
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: 100,
            child: Card(
              //clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 25.0,
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Text(
                          '${PersonModel.fromJson(list[index]).id}',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline3.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(child: Container(
                      height: 55,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                                '${PersonModel.fromJson(list[index]).name}',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.headline3.color,
                                fontSize: 18,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                              '${PersonModel.fromJson(list[index]).number}',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.headline3.color.withOpacity(.7),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),),
                    // we're gonna delete when dismiss the item
                    PopupMenuButton(
                      color: Colors.white,
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context){
                        return [
                          PopupMenuItem(
                            value: 'more',
                            child: Text('more information'),
                          ),
                          PopupMenuItem(
                            value: 'family',
                            child: Text('make them family'),
                          ),
                          PopupMenuItem(
                            value: 'friend',
                            child: Text('make them friend'),
                          ),
                          PopupMenuItem(
                            value: 'business',
                            child: Text('make them business'),
                          ),
                        ];
                      },
                      onSelected: (String value){
                        if (value == 'more') {

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'This feature is not implemented yet',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );

                        }
                        else if (value == 'family') {
                          RelCubit.get(context).updateRelationFromDatabase(
                              id: PersonModel.fromJson(list[index]).id,
                              newRelation: relationShips[0],
                          );
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(
                          //       'This person is your family now',
                          //       textAlign: TextAlign.center,
                          //       style: TextStyle(
                          //         fontSize: 15,
                          //       ),
                          //     ),
                          //   ),
                          // );
                        }
                        else if (value == 'friend') {
                          RelCubit.get(context).updateRelationFromDatabase(
                            id: PersonModel.fromJson(list[index]).id,
                            newRelation: relationShips[1],
                          );
                        }
                        else if (value == 'business') {
                          RelCubit.get(context).updateRelationFromDatabase(
                            id: PersonModel.fromJson(list[index]).id,
                            newRelation: relationShips[2],
                          );
                        }
                      },
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.delete_forever_rounded,
                    //     color: Colors.red,
                    //     size: 28,
                    //   ),
                    //   onPressed: (){
                    //     RelCubit.get(context).deleteFromDatabase(id: PersonModel.fromJson(list[index]).id);
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ) ,
        separatorBuilder: (context, index) => Divider(),
        itemCount: list.length,
      ),
    ),
    fallback: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.family_restroom,
            size: 70,
            color: Theme.of(context).accentColor.withOpacity(.6),
          ),
          SizedBox(height: 20,),
          Text(
            'No $relation Persons here',
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    ),
  );*/


}
