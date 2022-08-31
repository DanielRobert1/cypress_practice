import 'dart:convert';
import 'dart:typed_data';

import 'package:cypress_practice/app/config/app_config.dart';
import 'package:cypress_practice/features/album/model/albums_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AlbumService {
  Dio dioInstance;
  CacheManager cacheManager;
  AlbumService(this.dioInstance, this.cacheManager);

  Future<AlbumsResponse> getAlbums() async {
    List<dynamic> returnData = [];

    final cachedAlbums = await cacheManager.getFileFromCache("albums");
    if (cachedAlbums == null) {
      returnData = await compute(_getApiAlbums, {'dioInstance': dioInstance, 'cacheManager': cacheManager});
      cacheManager.putFile("${AppConfig.baseUrl}/albums", convertStringToUint8List(jsonEncode(returnData)), key: "albums");
    } else {
      returnData = jsonDecode(await cachedAlbums.file.readAsString());
    }

    print(returnData);

    return AlbumsResponse.fromJson(returnData);
  }

  static Future<List<dynamic>> _getApiAlbums(Map<String, dynamic> args) async {
    Dio dioInstance = args['dioInstance'];
    //CacheManager cacheManager = args['cacheManager'];
    List<dynamic> returnData = [];
    Response response = await dioInstance.get('/albums');
    final List<dynamic> responseData = response.data;

    List<Future<dynamic>> imageCalls = [];

    //queue up image calls
    for (var element in responseData) {
      imageCalls.add(dioInstance.get("/photos?albumId=${element['id']}"));
    }

    final res = await Future.wait(imageCalls);

    for (var i = 0; i < responseData.length; i++) {
      // List<Future<FileInfo>> imageDownloadCalls = [];
      // for (var image in res[i].data) {
      //   imageDownloadCalls.add(cacheManager.downloadFile(image['url']));
      // }

      // List<FileInfo> imageRes = await Future.wait(imageDownloadCalls);

      //int index = 0;
      var images = res[i].data.map((image) {
        var returnImage = Map<String, dynamic>.from(image);
        //returnImage['localPath'] = imageRes[index].file.path;
        returnImage['localPath'] = '';
        //index += 1;
        return returnImage;
      }).toList();

      var ele = {...responseData[i], "images": images};

      returnData.add(ele);
    }

    return returnData;
  }

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }
}
