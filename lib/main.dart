import 'package:cypress_practice/app/dependencies/dependency_factory.dart';
import 'package:cypress_practice/app/dependencies/dependency_provider.dart';
import 'package:cypress_practice/features/album/bloc/album_bloc.dart';
import 'package:cypress_practice/features/album/presentation/screens/album_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DependencyProvider(
      dependencyFactory: DependencyFactory(),
      child: MaterialApp(
        title: 'Cypress Practice',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey.shade200,
        ),
        home: BlocProvider<AlbumBloc>(
          create: (context) => context.read<BlocCreator<AlbumBloc>>().call(context),
          child: const AlbumScreen(title: 'Practice Task - Aigbe Daniel'),
        ),
      ),
    );
  }
}
