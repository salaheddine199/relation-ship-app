import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:relation_ships_program/layout/cubit/cubit.dart';
import 'package:relation_ships_program/layout/cubit/states.dart';
import 'package:relation_ships_program/models/person_model.dart';
import 'package:relation_ships_program/shared/components.dart';

class AddNewPerson extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _numberController = TextEditingController();
  var _birthDateController = TextEditingController();
  var _informationAboutController = TextEditingController();
  var _relationController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelCubit, RelStates>
      (
      listener: (context, state){
        if(state is RelInsertDatabase){
          Navigator.pop(context);
        }
      },
      builder: (context, state){

        RelCubit cubit = RelCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Adding A New Person',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      myTestFormField(
                        validator: (String value) {
                          if (value.isEmpty) return 'name must not be empty';
                          return null;
                        },
                        controller: _nameController,
                        label: 'name: ',
                        context: context,
                        //icon: Icon(Icons.title),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      myTestFormField(
                        context: context,
                        validator: (String value) {
                          if (value.isEmpty) return 'number must not be empty';
                          return null;
                        },
                        keyboard: TextInputType.number,
                        controller: _numberController,
                        label: 'number: ',
                        //icon: Icon(Icons.title),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      myTestFormField(
                        context: context,
                        validator: (String value) {
                          if (value.isEmpty) return 'brith date must not be empty';
                          return null;
                        },
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.utc(1950),
                            lastDate: DateTime.utc(2025),
                          ).then((value) {
                            String _date =
                                '${value.day}/${value.month}/${value.year}';
                            _birthDateController.text = _date;
                            print(_birthDateController.text);
                          }).catchError((error) {
                            print(
                                'error when showing a date picker : ${error.toString()}');
                          });
                        },
                        controller: _birthDateController,
                        label: 'birth date: ',
                        //icon: Icon(Icons.title),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      myTestFormField(
                        context: context,
                        max: 3,
                        validator: (String value) {
                          if (value.isEmpty) return 'information must not be empty';
                          return null;
                        },
                        controller: _informationAboutController,
                        label: 'information: ',
                        //icon: Icon(Icons.title),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      RadioGroup<String>.builder(
                        //textColor: Colors.white,
                        direction: Axis.horizontal,
                        groupValue: cubit.radioBtnValue,
                        onChanged: (value) {
                          //_relationController.text = 'familyyyyyy';
                          cubit.changeRadioButton(value);
                          print('***** $value');
                        },
                        items: [
                          'family',
                          'friend',
                          'business',
                        ],

                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),


                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Theme.of(context).accentColor,

                        ),
                        width: double.infinity ,
                        margin: EdgeInsets.symmetric(horizontal: 50.0,),
                        child: MaterialButton(
                            onPressed: (){
                              _relationController.text = cubit.radioBtnValue;
                              //print(_relationController.text);
                              if(_formKey.currentState.validate()){
                                var person = PersonModel(
                                  name: _nameController.text,
                                  number: _numberController.text,
                                  informationAbout: _informationAboutController.text,
                                  birthDate: _birthDateController.text,
                                  relation: _relationController.text,
                                );

                                cubit.insertToDatabase(person: person);
                              }
                            },
                          child: Text('Add', style: TextStyle(color: Colors.white,),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
