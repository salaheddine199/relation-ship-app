import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relationships/layout/cubit/cubit.dart';
import 'package:relationships/layout/cubit/states.dart';
import 'package:relationships/shared/components.dart';

class FriendsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelCubit,RelStates>(
      listener: (context, state){},
      builder: (context, state){
        List list = RelCubit.get(context).friends;
        return buildOurPersonItem(context, list,'Friend');
      },
    );
  }
}
