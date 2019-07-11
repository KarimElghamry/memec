import 'package:flutter/material.dart';
import 'package:memec/src/blocs/global.dart';
import 'package:memec/src/models/loading_state.dart';
import 'package:memec/src/models/meme.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    final double _screenHeight = MediaQuery.of(context).size.height;
    _showSnackOnDownload(context);

    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: Color(0xFF0F2437),
        body: Padding(
          padding: const EdgeInsets.only(
            bottom: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: _screenHeight / 1.7,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: StreamBuilder<MapEntry<Meme, LoadingState>>(
                        stream: Observable.combineLatest2(
                            _globalBloc.memesBloc.currentMeme$,
                            _globalBloc.memesBloc.loadingState$,
                            (a, b) => MapEntry<Meme, LoadingState>(a, b)),
                        builder: (BuildContext context,
                            AsyncSnapshot<MapEntry<Meme, LoadingState>>
                                snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              width: double.infinity,
                              height: _screenHeight / 1.81,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final LoadingState _state = snapshot.data.value;
                          if (_state == LoadingState.loading) {
                            return Container(
                              width: double.infinity,
                              height: _screenHeight / 1.81,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          if (_state == LoadingState.error) {
                            return Container(
                              width: double.infinity,
                              height: _screenHeight / 1.81,
                              child: Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                  size: 40.0,
                                ),
                              ),
                            );
                          }

                          final Meme _meme = snapshot.data.key;

                          return Stack(
                            children: <Widget>[
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) {
                                        return GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: Container(
                                            alignment: Alignment.center,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            child: Hero(
                                              tag: "meme",
                                              child: FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                image: _meme.url,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: _screenHeight / 1.81,
                                  child: Hero(
                                    tag: "meme",
                                    child: FadeInImage.memoryNetwork(
                                      fit: BoxFit.fill,
                                      placeholder: kTransparentImage,
                                      image: _meme.url,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RawMaterialButton(
                        onPressed: () {
                          _globalBloc.memesBloc.downloadCurrentMeme();
                        },
                        child: Icon(
                          Icons.file_download,
                          size: 28,
                          color: Colors.white,
                        ),
                        shape: CircleBorder(),
                        fillColor: Colors.pink,
                        splashColor: Colors.greenAccent,
                        padding: EdgeInsets.all(16.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      _globalBloc.memesBloc.fetchNextMeme();
                    },
                    color: Colors.pink,
                    splashColor: Colors.greenAccent,
                    highlightColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Another One!",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackOnDownload(BuildContext context) {
    final _stream =
        Provider.of<GlobalBloc>(context).memesBloc.isImageDownloadSuccessful$;
    _stream.listen(
      (data) {
        _key.currentState.showSnackBar(
          SnackBar(
            content: data
                ? Text("Downloaded Successfully!")
                : Text("Download Failed."),
          ),
        );
      },
    );
  }
}
