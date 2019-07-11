import 'package:image_downloader/image_downloader.dart';
import 'package:memec/src/models/loading_state.dart';
import 'package:memec/src/models/meme.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MemesBloc {
  String _apiUrl;
  BehaviorSubject<Meme> _currentMeme$;
  BehaviorSubject<LoadingState> _loadingState$;
  BehaviorSubject<bool> _isImageDownloadSuccessful$;

  BehaviorSubject<Meme> get currentMeme$ => _currentMeme$;
  BehaviorSubject<LoadingState> get loadingState$ => _loadingState$;
  BehaviorSubject<bool> get isImageDownloadSuccessful$ =>
      _isImageDownloadSuccessful$;

  MemesBloc() {
    _currentMeme$ = BehaviorSubject<Meme>();
    _loadingState$ = BehaviorSubject<LoadingState>();
    _isImageDownloadSuccessful$ = BehaviorSubject<bool>();
    _apiUrl = "https://meme-api.herokuapp.com/gimme";
    fetchNextMeme();
  }

  Future<void> fetchNextMeme() async {
    updateLoadingState(LoadingState.loading);
    http.Response _response;
    try {
      _response = await http.get(_apiUrl);
    } catch (e) {
      updateLoadingState(LoadingState.error);
      return;
    }
    if (_response.statusCode != 200) {
      updateLoadingState(LoadingState.error);
      return;
    }

    final String _data = _response.body;
    final Map<String, dynamic> _json = jsonDecode(_data);
    final Meme _meme = Meme.fromJson(_json);
    _currentMeme$.add(_meme);
    updateLoadingState(LoadingState.done);
  }

  void updateLoadingState(LoadingState state) {
    _loadingState$.add(state);
  }

  void downloadCurrentMeme() async {
    final _temp = await ImageDownloader.downloadImage(_currentMeme$.value.url);
    if (_temp == null) {
      _isImageDownloadSuccessful$.add(false);
      return;
    }
    _isImageDownloadSuccessful$.add(true);
  }

  void dispose() {
    _currentMeme$.close();
    _loadingState$.close();
    _isImageDownloadSuccessful$.close();
  }
}
