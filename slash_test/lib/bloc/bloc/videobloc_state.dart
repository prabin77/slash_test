part of 'videobloc_bloc.dart';

@immutable
abstract class VideoblocState {
  final String playingVideo;
  final String lastplayed;
  const VideoblocState(
    this.playingVideo,
    this.lastplayed,
  );
}

class VideoblocInitial extends VideoblocState {
  const VideoblocInitial(super.playingVideo, super.lastplayed);
}

class VideoblocUpdate extends VideoblocState {
  const VideoblocUpdate(super.playingVideo, super.lastplayed);
}
