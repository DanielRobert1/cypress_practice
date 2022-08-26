class AlbumArt {
  final String url;
  final String thumbnailUrl;

  const AlbumArt({
    required this.url,
    required this.thumbnailUrl,
  });

  factory AlbumArt.fromJson(Map<String, dynamic> responseData) {
    return AlbumArt(
      url: responseData['url'],
      thumbnailUrl: responseData['thumbnailUrl'],
    );
  }
}
