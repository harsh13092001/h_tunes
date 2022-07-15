import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h_tunes/main.dart';
import 'package:h_tunes/service/get.dart';
import 'package:h_tunes/service/trackModel.dart';
import 'package:h_tunes/views/home.dart';

import '../bloc/bloc.dart';

class LyricsPage extends StatefulWidget {
  final int track_id;
  const LyricsPage({Key? key, required this.track_id}) : super(key: key);

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => TrackInfo(),
          ),
          RepositoryProvider(
            create: (context) => Lyrics(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Center(
                child: Text(
              "Track Details",
              style: TextStyle(color: Colors.black),
            )),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(),
                    Container(
                      child: BlocProvider(
                        create: (context) => SongPageBloc(
                            RepositoryProvider.of<TrackInfo>(context),
                            widget.track_id)
                          ..add(LoadApiEvent()),
                        child: BlocBuilder<SongPageBloc, HomeState>(
                            builder: (context, state) {
                          
                          if (state is SongLoadedState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Text(state.track_name,
                                          style: TextStyle(fontSize: 18),
                                          overflow: TextOverflow.clip),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Artist:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Text(state.artist_name,
                                          style: TextStyle(fontSize: 18),
                                          overflow: TextOverflow.clip),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Album name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Text(state.album_name,
                                          style: TextStyle(fontSize: 18),
                                          overflow: TextOverflow.clip),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Explicit',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Text(state.explicit.toString(),
                                          style: TextStyle(fontSize: 18),
                                          overflow: TextOverflow.clip),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rating',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Text(state.rating.toString(),
                                          style: TextStyle(fontSize: 18),
                                          overflow: TextOverflow.clip),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ),
                    ),
                    BlocProvider(
                      create: (context) => LyricsPageBloc(
                          RepositoryProvider.of<Lyrics>(context),
                          widget.track_id)
                        ..add(LoadApiEvent()),
                      child: BlocBuilder<LyricsPageBloc, HomeState>(
                          builder: (context, state) {
                        if (state is DataLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is LyricsLoadedState) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lyrics',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                Text(state.lyrics,
                                    style: TextStyle(fontSize: 18),
                                    overflow: TextOverflow.clip),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                    )
                  ]),
            ),
          ),
        ));
  }
}
