import 'package:flutter/material.dart';
import 'package:memec/src/blocs/global.dart';
import 'package:memec/src/models/meme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    final double _screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
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
                      child: StreamBuilder<Meme>(
                          stream: _globalBloc.memesBloc.currentMeme$,
                          builder: (BuildContext context,
                              AsyncSnapshot<Meme> snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                width: double.infinity,
                                height: _screenHeight / 1.81,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final Meme _meme = snapshot.data;
                            return Container(
                              width: double.infinity,
                              height: _screenHeight / 1.81,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_meme.url),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RawMaterialButton(
                        onPressed: () {},
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
              Container(
                height: _screenHeight / 5,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Re-rolls",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            Text(
                              "1",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Container(
                        height: double.infinity,
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Saved",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
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
}
