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
      returnData = await compute(_getApiAlbums, dioInstance);
      cacheManager.putFile("${AppConfig.baseUrl}/albums", convertStringToUint8List(jsonEncode(returnData)), key: "albums");
    } else {
      returnData = jsonDecode(await cachedAlbums.file.readAsString());
    }

    return AlbumsResponse.fromJson(returnData);
  }

  static Future<List<dynamic>> _getApiAlbums(Dio dioInstance) async {
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
      var images = res[i].data.take(4).map((image) {
        return image;
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
