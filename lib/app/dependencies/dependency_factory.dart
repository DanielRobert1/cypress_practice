import 'package:cypress_practice/app/config/app_config.dart';
import 'package:cypress_practice/features/album/bloc/album_bloc.dart';
import 'package:cypress_practice/features/album/service/album_service.dart';
import 'package:cypress_practice/features/album/service/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef BlocCreator<T> = T Function(BuildContext context);

abstract class DependencyFactoryBase {
  Dio createDio(BuildContext context);
  AlbumService albumService(BuildContext context);
  BlocCreator<AlbumBloc> get albumBlocCreator;
  AppCacheManager appCacheManager(BuildContext context);
}

class DependencyFactory extends DependencyFactoryBase {
  @override
  Dio createDio(BuildContext context) {
    var _dio = Dio(
      BaseOptions(baseUrl: AppConfig.baseUrl, contentType: 'application/json'),
    );

    return _dio;
  }

  @override
  AppCacheManager appCacheManager(BuildContext context) => AppCacheManager();

  @override
  AlbumService albumService(BuildContext context) => AlbumService(context.read<Dio>(), context.read<AppCacheManager>());

  @override
  BlocCreator<AlbumBloc> get albumBlocCreator => (BuildContext context) => AlbumBloc(context.read<AlbumService>());
}
