import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relation_ships_program/layout/cubit/cubit.dart';
import 'package:relation_ships_program/layout/cubit/states.dart';
import 'package:relation_ships_program/shared/components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelCubit,RelStates>(
      listener: (context, state){},
      builder: (context, state){
        if(state is RelGetLoadingDatabase || state is RelGetLoadingCreateDatabase)
          return Center(child: CircularProgressIndicator());
        // else{}
        List list = RelCubit.get(context).business;
        return buildOurPersonItem(context, list, 'Business');
      },
    );
  }
}
