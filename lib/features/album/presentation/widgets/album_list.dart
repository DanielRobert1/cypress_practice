import 'package:cached_network_image/cached_network_image.dart';
import 'package:cypress_practice/features/album/model/album.dart';
import 'package:cypress_practice/features/album/service/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumList extends StatelessWidget {
  final List<Album> list;
  const AlbumList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return list.isEmpty
        ? const Center(
            child: Text("No Records"),
          )
        : ListView.builder(
            cacheExtent: 100,
            itemBuilder: (context, index) {
              var item = list[index % list.length];
              return Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text("${item.id} ${item.title}"),
                    ),
                    SizedBox(
                      width: screenSize.width,
                      height: 100,
                      child: ListView.builder(
                        cacheExtent: 100,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, subIndex) {
                          var itemImage = item.artList[subIndex % item.artList.length];
                          return Container(
                            width: screenSize.width / 3 - 30,
                            height: 100,
                            padding: const EdgeInsets.only(left: 10),
                            child: CachedNetworkImage(
                              cacheManager: context.read<AppCacheManager>(),
                              cacheKey: itemImage.url,
                              imageUrl: itemImage.url,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
