import 'package:memec/src/models/meme.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    final String _data = _response.body;
    final Map<String, dynamic> _json = jsonDecode(_data);
    final Meme _meme = Meme.fromJson(_json);
    _currentMeme$.add(_meme);
    print(_data);
  }

  void dispose() {
    _currentMeme$.close();
  }
}
