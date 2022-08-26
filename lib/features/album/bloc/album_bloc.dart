import 'package:cypress_practice/features/album/model/albums_response.dart';
import 'package:cypress_practice/features/album/service/album_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumService service;
  AlbumBloc(this.service, {AlbumState? initialState}) : super(initialState ?? AlbumInitial()) {
    on<AlbumFetch>(_onAlbumFetched);
  }

  Future<void> _onAlbumFetched(AlbumFetch event, Emitter<AlbumState> emit) async {
    if (state is AlbumInitial) {
      try {
        emit(AlbumLoading());
        final albums = await _fetchAlbums();
        return emit(AlbumLoaded(albums));
      } catch (_) {
        emit(AlbumLoadingError(_.toString()));
      }
    } else {
      UnsupportedError('Event not supported');
    }
  }

  Future<AlbumsResponse> _fetchAlbums() async {
    return service.getAlbums();
  }
}
