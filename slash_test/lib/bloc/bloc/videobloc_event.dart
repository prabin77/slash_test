part of 'videobloc_bloc.dart';

@immutable
abstract class VideoblocEvent {}

class SelectNew extends VideoblocEvent {
  String playedVideo;
  SelectNew({
    required this.playedVideo,
  });
}
