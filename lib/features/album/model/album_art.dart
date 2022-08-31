class AlbumArt {
  final String url;
  final String thumbnailUrl;
  final String? localPath;

  const AlbumArt({
    required this.url,
    required this.thumbnailUrl,
    this.localPath,
  });

  factory AlbumArt.fromJson(Map<String, dynamic> responseData) {
    return AlbumArt(
      url: responseData['url'],
      thumbnailUrl: responseData['thumbnailUrl'],
      localPath: responseData['localPath'],
    );
  }
}
