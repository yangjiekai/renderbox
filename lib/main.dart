import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

AudioCache player=new AudioCache();
void _onClicked (String filename){
  player.play ("$filename.mp3");
}

List data=[

  'KICK',
  'TAP',
  'SNARE',
  'CLAPZ',
  'BOOM',
  'HIHAT',
  'GUN',
  'CLAP',
  'BASS 1',
  'BASS 2',
  'ROBOT',
  'VOX',
  'PIANO',
  'WAR',
  'LISTEN',
  'SUB',

];

class MyApp extends StatelessWidget {
  Random random =new Random();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Grid(),
    );
  }
}

class Grid extends StatefulWidget {
  @override
  GridState createState() {
    return new GridState();
  }
}

class GridState extends State<Grid> {
  final Set<int> selectedIndexes = Set<int>();
  final key = GlobalKey();
  final Set<_Foo> _trackTaped = Set<_Foo>();

  _detectTapedItem(PointerEvent event) {

    final RenderBox box =  key.currentContext.findRenderObject();
    final result = BoxHitTestResult();
    Offset local = box.globalToLocal(event.position);

    if (box.hitTest(result, position: local)) {
      for (final hit in result.path) {
        /// temporary variable so that the [is] allows access of [index]
        final target = hit.target;
        if ( target is _Foo &&
            !_trackTaped.contains(target)) {


          _trackTaped.add(target);
          _selectIndex(target.index);

          _onClicked(data[target.index]);
        }

      }

    }

  }

  _selectIndex(int index) {
    setState(() {
      selectedIndexes.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(

      onPointerDown: _detectTapedItem,
      onPointerMove: _detectTapedItem,
      onPointerUp: _clearSelection,

      child: GridView.builder(
        key: key,
        itemCount: data.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemBuilder: (context, index) {
          return Foo(

            index: index,
            child: Container(
              color: selectedIndexes.contains(index) ? Colors.red : Colors.blue,
            ),
          );
        },
      ),
    );
  }

  void _clearSelection(PointerUpEvent event) {
    _trackTaped.clear();
    setState(() {
      selectedIndexes.clear();
    });
  }
}

class Foo extends SingleChildRenderObjectWidget {
  final int index;

  Foo({Widget child, this.index, Key key}) : super(child: child, key: key);

  @override
  _Foo createRenderObject(BuildContext context) {
    return _Foo()..index = index;
  }

  @override
  void updateRenderObject(BuildContext context, _Foo renderObject) {
    renderObject..index = index;
  }
}

class _Foo extends RenderProxyBox {
  int index;
}