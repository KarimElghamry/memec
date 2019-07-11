import 'package:memec/src/models/meme.dart';
import 'package:rxdart/subjects.dart';

class MemesBloc {
  BehaviorSubject<Meme> _currentMeme$;

  BehaviorSubject<Meme> get currentMeme$ => _currentMeme$;

  MemesBloc() {
    _currentMeme$ = BehaviorSubject<Meme>();
  }

  void dispose() {
    _currentMeme$.close();
  }
}
