import 'package:cypress_practice/features/album/bloc/album_bloc.dart';
import 'package:cypress_practice/features/album/presentation/widgets/album_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<AlbumBloc>(context).add(AlbumFetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case AlbumInitial:
            case AlbumLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case AlbumLoaded:
              final casted = state as AlbumLoaded;
              return AlbumList(list: casted.albumList.albums);
            case AlbumLoadingError:
            default:
              final casted = state as AlbumLoadingError;
              return Column(
                children: [
                  Text(casted.reason),
                ],
              );
          }
        },
      ),
    );
  }
}
