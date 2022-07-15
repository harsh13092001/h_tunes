
import 'package:equatable/equatable.dart';
import 'package:h_tunes/service/get.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part  'stateBloc.dart';
part  'eventBloc.dart';

class HomeBloc extends Bloc<GetEvent, HomeState> {
  final Fetch _boredService;
  final ConnectivityService _connectivityService;
 

  HomeBloc(this._boredService, this._connectivityService ) : super(DataLoadingState()) {
     _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        
        add(NoInternetEvent());
      } else {
        
        add(LoadApiEvent());
      }
    });
    on<LoadApiEvent>((event, emit) async {
      emit(DataLoadingState());
      try{final trackName = await _boredService.trackList();
      emit(DataLoadedState(trackName.message.body.trackList));
    }catch(e){
      emit(ErrorState(e.toString()));
    }
      });

    on<NoInternetEvent>((event, emit) {
      emit(NoInternetState());
    });
  }
}




class SongPageBloc extends Bloc<GetEvent, HomeState> {
  final TrackInfo _boredService;
  final int track_id;
 

  SongPageBloc(this._boredService, this.track_id) : super(DataLoadingState()) {
    
    on<LoadApiEvent>((event, emit) async {
 
      emit(DataLoadingState());
      try{final TrackInfo = await _boredService.Track(track_id);
      var component =TrackInfo.message.body.track;
      emit(SongLoadedState(component.trackName,component.artistName,component.albumName,component.explicit,component.trackRating));
    }catch(e){
      emit(ErrorState(e.toString()));
    }
      });

    
  }
}

class LyricsPageBloc extends Bloc<GetEvent, HomeState> {
  final Lyrics _boredService;
  final int track_id;


  LyricsPageBloc(this._boredService, this.track_id) : super(DataLoadingState()) {
    
    on<LoadApiEvent>((event, emit) async {
     
      emit(DataLoadingState());
      try{final trackName = await _boredService.lyrics(track_id);
      emit(LyricsLoadedState(trackName.message.body.lyrics.lyricsBody));
    }catch(e){
      emit(ErrorState(e.toString()));
    }
      });

   
  }
}
