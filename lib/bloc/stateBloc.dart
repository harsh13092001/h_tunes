
part of 'bloc.dart';

abstract class HomeState extends Equatable{
  const HomeState();
}
class NoInternetState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class DataLoadingState extends HomeState {
  @override 
  List<Object> get props=>[];

}
class DataLoadedState extends HomeState{
  late final List trendTracks;
  

  DataLoadedState(this.trendTracks);
  @override
  // TODO: implement props
  List<Object?> get props => [trendTracks];
}
class ErrorState extends HomeState {
  final String error;

  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}


class songLoadingState extends HomeState {
  @override 
  List<Object> get props=>[];

}
class SongLoadedState extends HomeState{
  late final String track_name;
    late final String artist_name;
  late final String album_name;
  late final int explicit;
  late final int rating;
   

  SongLoadedState(this.track_name,this.artist_name,this.album_name,this.explicit,this.rating);
  @override
  // TODO: implement props
  List<Object?> get props => [track_name,artist_name,album_name,explicit,rating];
}

class LyricsLoadedState extends HomeState{
  late final String lyrics;
  
  
  LyricsLoadedState(this.lyrics);
  @override
  // TODO: implement props
  List<Object?> get props => [lyrics];
}

