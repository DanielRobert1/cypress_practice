import 'package:cypress_practice/features/album/model/album.dart';

class AlbumsResponse {
  final List<Album> albums;

  AlbumsResponse({
    required this.albums,
  });

  factory AlbumsResponse.fromJson(List<dynamic> responseData) {
    return AlbumsResponse(albums: responseData.map<Album>((e) => Album.fromJson(e)).toList());
  }
}
