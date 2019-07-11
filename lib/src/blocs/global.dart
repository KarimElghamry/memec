import 'package:memec/src/blocs/memes.dart';

class GlobalBloc {
  MemesBloc _memesBloc;

  MemesBloc get memesBloc => _memesBloc;

  GlobalBloc() {
    _memesBloc = MemesBloc();
  }

  void dispose() {
    memesBloc.dispose();
  }
}
