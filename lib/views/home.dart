import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h_tunes/bloc/bloc.dart';

import 'package:h_tunes/service/get.dart';

import 'package:h_tunes/views/song.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => Fetch(),
        ),
        RepositoryProvider(
          create: (context) => ConnectivityService(),
        )
      ],
      child: BlocProvider(
          create: (context) => HomeBloc(
                RepositoryProvider.of<Fetch>(context),
                RepositoryProvider.of<ConnectivityService>(context),
              )..add(LoadApiEvent()),
          child: Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Text(
                "Trending",
                style: TextStyle(color: Colors.black),
              )),
              backgroundColor: Colors.white,
            ),
            body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is NoInternetState) {
                return Center(
                    child: Text(
                  'no internet ',
                  style: TextStyle(color: Colors.black),
                ));
              }
              if (state is DataLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is DataLoadedState) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.trendTracks.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LyricsPage(
                                            track_id: state.trendTracks[index]
                                                .track.trackId!)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  width: 200,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 220, 223, 224),
                                        offset: const Offset(
                                          0.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ),
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.music_note_rounded,
                                        color:
                                            Color.fromARGB(255, 189, 188, 188),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Width / 3,
                                              height: Height / 35,
                                              child: Text(
                                                  state.trendTracks[index].track
                                                      .trackName!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            SizedBox(
                                              width: Width / 2,
                                              child: Text(
                                                  state.trendTracks[index].track
                                                      .albumName!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                  overflow: TextOverflow.clip),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: Width / 3,
                                        child: Text(
                                            state.trendTracks[index].track
                                                .artistName!
                                                .toString(),
                                            overflow: TextOverflow.clip),
                                      ),
                                      Divider()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
              return Container();
            }),
          )),
    );
  }
}
