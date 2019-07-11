import 'package:memec/src/models/connection_state.dart';
import 'package:memec/src/models/meme.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MemesBloc {
  String _apiUrl;
  BehaviorSubject<Meme> _currentMeme$;
  BehaviorSubject<ConnectionState> _connectionState$;

  BehaviorSubject<Meme> get currentMeme$ => _currentMeme$;

  MemesBloc() {
    _currentMeme$ = BehaviorSubject<Meme>();
    _connectionState$ = BehaviorSubject<ConnectionState>();
    _apiUrl = "https://meme-api.herokuapp.com/gimme";
    fetchNextMeme();
  }

  Future<void> fetchNextMeme() async {
    _connectionState$.add(ConnectionState.loading);
    final _response = await http.get(_apiUrl);
    if (_response.statusCode != 200) {
      _connectionState$.add(ConnectionState.error);
      return;
    }
    final String _data = _response.body;
    final Map<String, dynamic> _json = jsonDecode(_data);
    final Meme _meme = Meme.fromJson(_json);
    _currentMeme$.add(_meme);
    _connectionState$.add(ConnectionState.done);
  }

  void dispose() {
    _currentMeme$.close();
  }
}
