import 'package:cypress_practice/app/dependencies/dependency_factory.dart';
import 'package:cypress_practice/features/album/bloc/album_bloc.dart';
import 'package:cypress_practice/features/album/service/album_service.dart';
import 'package:cypress_practice/features/album/service/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DependencyProvider extends StatelessWidget {
  final Widget child;
  final DependencyFactoryBase dependencyFactory;

  const DependencyProvider({
    Key? key,
    required this.child,
    required this.dependencyFactory,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Dio>(create: dependencyFactory.createDio),
        RepositoryProvider<AppCacheManager>(create: dependencyFactory.appCacheManager),
        RepositoryProvider<AlbumService>(
          create: dependencyFactory.albumService,
        ),
        RepositoryProvider<BlocCreator<AlbumBloc>>(
          create: (_) => dependencyFactory.albumBlocCreator,
        ),
      ],
      child: Builder(
        builder: (context) => child,
      ),
    );
  }
}
