// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app_theme.dart';
// import 'navigation_home_screen.dart';
// import 'home_screen.dart';
// import 'package:flutter_app/fitness_app/fitness_app_home_screen.dart';
import 'package:english_words/english_words.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_app/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: HomePage(),
    );
    // return MaterialApp(
    //   title: 'Startup Name Generator',
    //   theme: new ThemeData(          // 新增代码开始...
    //     primaryColor: Colors.yellow,
    //   ),
    //   home: RandomWords(),
    // );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>(); // 新增本行
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          // 新增代码开始 ...
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        // 新增代码开始 ...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // 增加如下 9 行代码...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        // 新增如下20行代码 ...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return new Scaffold(
            // 新增 6 行代码开始 ...
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PopupController _popupController = PopupController();
  final MapController _mapController = MapController();
  List<Marker> markers;
  int pointIndex;
  double zoom = 8;
  double maxZoom = 14;
  double minZoom = 2;
  LatLng center = LatLng(25.033671, 121.564427);

  @override
  void initState() {
    pointIndex = 0;
    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(25.033671, 121.564427),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3498, -6.2603),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(49.8566, 3.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              if (this.zoom + 1 > this.maxZoom) {
                this.zoom = this.maxZoom;
              } else {
                this.zoom += 1;
              }
              _mapController.move(this.center, this.zoom);
              print('change zoom to ${this.zoom}');
            });
          },
          heroTag: null,
        ),
        FloatingActionButton(
          child: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (this.zoom - 1 < this.minZoom) {
                this.zoom = this.minZoom;
              } else {
                this.zoom -= 1;
              }
              _mapController.move(this.center, this.zoom);
              print('change zoom to ${this.zoom}');
            });
          },
          heroTag: null,
        ),
        SizedBox(
          height: 10,
        )
      ]),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     pointIndex++;
      //     if (pointIndex >= points.length) {
      //       pointIndex = 0;
      //     }
      //     setState(() {
      //       markers[0] = Marker(
      //         point: points[pointIndex],
      //         anchorPos: AnchorPos.align(AnchorAlign.center),
      //         height: 30,
      //         width: 30,
      //         builder: (ctx) => Icon(Icons.pin_drop),
      //       );
      //
      //       // one of this
      //       markers = List.from(markers);
      //       // markers = [...markers];
      //       // markers = []..addAll(markers);
      //     });
      //   },
      // ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          // onPositionChanged: {},
          onPositionChanged: (position, hasGesture) {
            if (position.center != null && position.zoom != null) {
              this.center = position.center;
              _mapController.move(position.center, position.zoom);
            }
          },
          center: this.center,
          zoom: this.zoom,
          plugins: [
            //MarkerClusterPlugin(),
          ],
          onTap: (_) => _popupController
              .hidePopup(), // Hide popup when the map is tapped.
        ),
        layers: [
          TileLayerOptions(
              urlTemplate:
                  'https://fms.uming.com.tw:8087/styles/fsm-dark/{z}/{x}/{y}.png'),
          MarkerLayerOptions(),
          // MarkerClusterLayerOptions(
          //   maxClusterRadius: 120,
          //   disableClusteringAtZoom: 6,
          //   size: Size(40, 40),
          //   anchor: AnchorPos.align(AnchorAlign.center),
          //   fitBoundsOptions: FitBoundsOptions(
          //     padding: EdgeInsets.all(50),
          //   ),
          //   markers: markers,
          //   polygonOptions: PolygonOptions(
          //       borderColor: Colors.blueAccent,
          //       color: Colors.black12,
          //       borderStrokeWidth: 3),
          //   popupOptions: PopupOptions(
          //       popupSnap: PopupSnap.top,
          //       popupController: _popupController,
          //       popupBuilder: (_, marker) => Container(
          //             width: 200,
          //             height: 100,
          //             color: Colors.white,
          //             child: GestureDetector(
          //               onTap: () => debugPrint("Popup tap!"),
          //               child: Text(
          //                 "Container popup for marker at ${marker.point}",
          //               ),
          //             ),
          //           )),
          //   builder: (context, markers) {
          //     return FloatingActionButton(
          //       child: Text(markers.length.toString()),
          //       onPressed: null,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
