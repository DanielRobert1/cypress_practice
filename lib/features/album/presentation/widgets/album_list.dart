import 'package:cached_network_image/cached_network_image.dart';
import 'package:cypress_practice/features/album/model/album.dart';
import 'package:cypress_practice/features/album/service/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumList extends StatelessWidget {
  final List<Album> list;
  final int limit;
  const AlbumList({Key? key, required this.list, this.limit = 4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return list.isEmpty
        ? const Center(
            child: Text("No Records"),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              var item = list[index % limit];
              return Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, .1), blurRadius: 1, offset: Offset(0, 0))],
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: screenSize.width,
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, subIndex) {
                          var itemImage = item.artList[subIndex % limit];
                          return SizedBox(
                            width: screenSize.width / 3 - 30,
                            height: 200,
                            child: CachedNetworkImage(
                              cacheManager: context.read<AppCacheManager>(),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Album ${item.id}"),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
