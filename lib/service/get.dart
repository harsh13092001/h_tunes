import 'package:h_tunes/service/lyricsModel.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'musicModel.dart';
import 'trackModel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final _connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((event) {
      connectivityStream.add(event);
    });
  }
}

class Fetch {
  Future<Musicmodel> trackList() async {
    final response = await get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=921623eb784143cc8e694eaed9d800c7'));
    if (response.statusCode == 200) {
      return musicmodelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class TrackInfo {
  Future<TrackModel> Track(int track_id) async {
    final response = await get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.get?track_id=${track_id}&apikey=921623eb784143cc8e694eaed9d800c7'));

    if (response.statusCode == 200) {
      return trackModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class Lyrics {
  Future<LyricsModel> lyrics(int track_id) async {
    final response = await get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${track_id}&apikey=921623eb784143cc8e694eaed9d800c7'));

    if (response.statusCode == 200) {
      return lyricsModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
