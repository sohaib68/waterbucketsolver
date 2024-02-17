import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterbucketsolver/app_settings/app_bloc_observer.dart';
import 'package:waterbucketsolver/app_settings/app_theme.dart';
import 'package:waterbucketsolver/pages/waterbucket_solver_cubit.dart';

import 'package:waterbucketsolver/pages/waterbucket_solver_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  Bloc.observer = AppBlocObserver();
  runApp(const WaterBucketApp());
}

class WaterBucketApp extends StatelessWidget {
  const WaterBucketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: BlocProvider(
        create: (context) => WaterBucketSolverCubit(),
        child: const WaterBucketSolverPage(),
      ),
    );
  }
}
