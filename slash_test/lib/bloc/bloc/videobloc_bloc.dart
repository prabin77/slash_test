import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'videobloc_event.dart';
part 'videobloc_state.dart';

class VideoblocBloc extends Bloc<VideoblocEvent, VideoblocState> {
  static const List<String> videos = [
    'assets/video2.mp4',
    'assets/video2.mp4',
    'assets/video2.mp4'
  ];
  VideoblocBloc() : super(VideoblocInitial(videos[1], "")) {
    on<VideoblocEvent>((event, emit) {
      if (event is SelectNew) {
        print('object call');
        // int lastIndex = videos.indexOf(event.playedVideo);
        int newIndex = 2;
        emit(VideoblocUpdate(videos[newIndex], event.playedVideo));
      }
    });
  }
}
