part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final AlbumsResponse albumList;
  const AlbumLoaded(this.albumList);
}

class AlbumLoadingError extends AlbumState {
  final String reason;
  const AlbumLoadingError(this.reason);
}
