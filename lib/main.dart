import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modlar/colors.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


    bool switching = false;
    Offset fingerPosition;
    Future<void> colorSwitcher() async{
      Future.delayed(Duration(milliseconds: 1200)).then((value) {
      setState(() {
        switching = true;
      });
      colorSwitcher();
      });
    }



 
Widget line(int gridwidth){
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(gridwidth, (index) => CellCube(this))
,),
  );
}

GlobalKey key = new GlobalKey();
final result = new BoxHitTestResult();

  void isTouchingContainer(BuildContext context, DragUpdateDetails details){
    RenderBox box = key.currentContext.findRenderObject();
    Offset offset = box.globalToLocal(details.globalPosition);
    //print(offset);
    setState(() {
          fingerPosition = offset;
    });
  }


  @override
  Widget build(BuildContext context) {
    int gridLength = (MediaQuery.of(context).size.height~/28);
    int gridWidth = (MediaQuery.of(context).size.width~/28);
    return Scaffold(
      backgroundColor: MyColors().backgroundColor(),
      body: Center(
        key: key,
        child: Column(
          // horizontal).
          children: <Widget>[
            Center(
              child: GestureDetector(
                        onPanUpdate: (details){
                          isTouchingContainer(context, details);
                        },
                         child: Column(
                  
                  children: List.generate(gridLength, (index) => line(gridWidth))
                  
                  ,),
              ),
            ),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Container(
                  height: 50,
                  decoration: new BoxDecoration(
                    color: MyColors().accentColor()
                  ),
                  child: Row(children: [
                    IconButton(
                      onPressed: (){

                      },

                      icon: Icon(Icons.color_lens, size: 24,)
                    )
                  ],),
                ),
              )
          ],
        ),
      ),
    );
  }
}


class CellCube extends StatefulWidget{
  _MyHomePageState parent;
  CellCube(this.parent);
  @override
  State<StatefulWidget> createState() =>_CellCube();

}

class _CellCube extends State<CellCube>{







double size = 20;
Color c = Colors.black;
bool isCurrentlyTouching = false;
GlobalKey key = new GlobalKey();
final result = BoxHitTestResult();
RenderBox box; 
int compareCount = 0;
@override
void initState() { 
  safeRun();
  super.initState();
  
}

    void safeRun(){
        if(compareCount == 0){
          comparePositions();
          setState(() {
           compareCount = 1; 
          });
        }
    }


      Future<void> comparePositions() async {
        
      await Future.delayed(Duration(milliseconds: 1200)).then((value){
      // print('test');
      try {
               box = key.currentContext.findRenderObject();
       if(widget.parent.fingerPosition == null){
          comparePositions();
       }else{
             Offset touchPos = widget.parent.fingerPosition;
             Offset cellPos = box.globalToLocal(touchPos);
              //  print('TouchPos: ' + widget.parent.fingerPosition.toString());
              //  print('CellPos : ' + box.globalToLocal(Offset.zero).toString());
                  if(cellPos.dx < 50 && cellPos.dy < 50 && c != Colors.white){
                    // print('hit');
                          setState(() {
                          c = Colors.white;
                          });
                    //  comparePositions();

                        }else{
                      comparePositions();
                        }
              
       }
      } catch (e) {
       // print('ERROR: Cannot Read Touch Position');
      }

      
     


      
  });


}



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 4, 3, 2),
      child: AnimatedContainer(
      duration: Duration(milliseconds: 600),
      key: key,
      width: size,
      height: size,
      decoration: new BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(4)
      ),
        ),
    );
  }

}