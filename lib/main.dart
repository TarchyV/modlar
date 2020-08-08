import 'package:flutter/material.dart';
import 'package:modlar/colors.dart';

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

    Future<void> colorSwitcher() async{
      Future.delayed(Duration(milliseconds: 1200)).then((value) {
      setState(() {
        switching = true;
      });
      colorSwitcher();
      });
    }



 
Widget line(){
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
                     children: List.generate(16, (index) => CellCube())
,),
  );
}






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().backgroundColor(),
      body: Center(
       
        child: Stack(
          fit: StackFit.loose,
          // horizontal).
          children: <Widget>[
            Center(
              child: Column(
                
                children: List.generate(30, (index) => line())
                
                ,),
            ),
              CustomPaint(
                size: Size.infinite,

              )
          
          ],
        ),
      ),
    );
  }
}


class CellCube extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_CellCube();

}

class _CellCube extends State<CellCube>{

double size = 20;
Color c = Colors.black;

  @override
  Widget build(BuildContext context) {
    return InkWell(
              onHover: (bool b){
                setState(() {
                      c = MyColors().randomColor();
                    });
              },
              onTap: (){
                    //  if(!switching){
                    //    colorSwitcher();
                    //  }
                    setState(() {
                      c = MyColors().randomColor();
                    });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 4, 3, 2),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  width: size,
                  height: size,
                  decoration: new BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(4)
                  ),
                ),
              ),
            );
  }

}