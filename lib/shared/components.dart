import 'package:flutter/material.dart';
import 'package:relationships/models/person_model.dart';

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

Widget buildOurPersonItem(context, list, String relation){
  if(list.length>0)
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (context, index)=> Container(
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
                        color: Theme.of(context).textTheme.headline3!.color,
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
                              color: Theme.of(context).textTheme.headline3!.color,
                              fontSize: 18,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                            '${PersonModel.fromJson(list[index]).number}',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline3!.color!.withOpacity(.7),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),),
                  IconButton(
                    icon: Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                      size: 28,
                    ),
                    onPressed: (){},
                  ),
                ],
              ),
            ),
          ),
        ) ,
        separatorBuilder: (context, index) => Divider(),
        itemCount: list.length,
      ),
    );

  else
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.family_restroom,
            size: 70,
            color: Theme.of(context)!.primaryColor.withOpacity(.6),
          ),
          SizedBox(height: 20,),
          Text(
            'No $relation Persons here',
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
   
}

