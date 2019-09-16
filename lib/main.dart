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
      home:
      Center(
          child: Container(
//            decoration: BoxDecoration(
//                gradient: LinearGradient(
//                    begin: Alignment.topRight,
//                    end: Alignment.bottomLeft,
//                    colors: [Colors.blueAccent, Colors.tealAccent]
//                )),
            child:  Grid(),
          ))





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
             // color: selectedIndexes.contains(index) ? Colors.red : Colors.blue,



              decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(8.0),
//                  gradient: LinearGradient(
//                      begin: Alignment.topRight,
//                      end: Alignment.bottomLeft,
//                      colors: selectedIndexes.contains(index) ?  [Colors.blue, Colors.red] : [Colors.black, Colors.yellow] ,
//
//
//
//                  )


                  gradient : RadialGradient(
                    center: const Alignment(0, 0), // near the top right
                    radius: 0.9,
                    colors: selectedIndexes.contains(index) ?[Colors.blue, Colors.red]  :[
                    //  const Color(0x3546AF ), // yellow sun
                      const Color(0xff6666 ), // yellow sun

                      const Color(0xFF0099FF), // blue sky
                    ],
                    stops: [0.4, 1.0],
                  )

              ),
              child: Center(
                child: 
//                Text(
//                  '',
//                  style: TextStyle(
//                      fontSize: 20.0,
//                      fontWeight: FontWeight.bold,
//                      color: Colors.white),
//                ),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomPaint(
                    painter: ShapesPainter(),
                    child: Container(height: 700,),
                  ),
                ),
              ),




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

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
//    // TODO: implement paint
//    final paint = Paint();
//    // set the color property of the paint
//    paint.color = Colors.deepOrange;
//    // center of the canvas is (x,y) => (width/2, height/2)
//    var center = Offset(size.width / 2, size.height / 2);
//
//    // draw the circle on centre of canvas having radius 75.0
//    canvas.drawCircle(center, 10.0, paint);
//
////////////////////////
//    paint.color = Colors.green[800];
//    paint.style = PaintingStyle.stroke;
//    paint.strokeWidth = 2.0;
//
//    var path = Path();
//
//    path.lineTo(size.width, size.height);
//
//    canvas.drawPath(path, paint);
//
//
/////////////////////
//
////    paint.color = Colors.green[800];
////    paint.style = PaintingStyle.fill; // Change this to fill
////
////
////
////    path.moveTo(0, size.height * 0.7);
////    path.moveTo(0.25, size.height * 0.25/2);
////    path.moveTo(0.75, size.height * 0.25/2);
////    path.moveTo(1, size.height * 0.25);
//////    path.quadraticBezierTo(
//////        size.width / 2, size.height / 2, size.width, size.height * 0.25);
////    path.lineTo(size.width, 0);
////    path.lineTo(0, 0);
////
////    canvas.drawPath(path, paint);
//    /////////////////
//
//
//    var paint2 = Paint();
//    paint2.color = Colors.green[800];
//    paint2.style = PaintingStyle.fill; // Change this to fill
//
//    var path2 = Path();
//
//    path2.moveTo(0, size.height * 0.25);
//    path2.quadraticBezierTo(
//        size.width / 2, size.height / 2, size.width, size.height * 0.25);
////    path2.lineTo(size.width, 0);
////    path2.lineTo(0, 0);
//
//    canvas.drawPath(path2, paint2);

  }
  @override
   bool shouldRepaint(CustomPainter oldDelegate) => false;
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