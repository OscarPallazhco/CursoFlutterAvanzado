import 'package:estados/bloc/user/user_cubit.dart';
import 'package:flutter/material.dart';

import 'package:estados/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => new UserCubit(),)  //anadir el cubit de manera global, similar al provider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'page1',
        routes: routes,
      ),
    );
  }
}
