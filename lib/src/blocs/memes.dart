import 'package:memec/src/models/meme.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;

class MemesBloc {
  String _apiUrl;
  BehaviorSubject<Meme> _currentMeme$;

  BehaviorSubject<Meme> get currentMeme$ => _currentMeme$;

  MemesBloc() {
    _currentMeme$ = BehaviorSubject<Meme>();
    _apiUrl = "https://meme-api.herokuapp.com/gimme";
    fetchNextMeme();
  }

  Future<void> fetchNextMeme() async {
    final _response = await http.get(_apiUrl);
    print(_response.body);
  }

  void dispose() {
    _currentMeme$.close();
  }
}
