import 'package:cypress_practice/features/album/model/album_art.dart';

class Album {
  final int id;
  final int userId;
  final String title;
  final List<AlbumArt> artList;

  const Album({
    required this.id,
    required this.userId,
    required this.title,
    required this.artList,
  });

  factory Album.fromJson(Map<dynamic, dynamic> responseData) {
    return Album(
      id: responseData['id'],
      userId: responseData['userId'],
      title: responseData['title'],
      artList: responseData['images'] != null ? responseData['images'].map<AlbumArt>((e) => AlbumArt.fromJson(e)).toList() : [],
    );
  }
}
