import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const TodoApp());
}

const String appName = "Todo";
const String appNameSubText = "Take charge of your time";
const String emailTextBoxHint = "Your email address?";
const String homeEnterButtonText = "Enter";

const MaterialColor backgroundYellow = MaterialColor(0xffffee93,
    {
      50: Color.fromRGBO(0xff, 0xee, 0x93, .1),
      100: Color.fromRGBO(0xff, 0xee, 0x93, .2),
      200: Color.fromRGBO(0xff, 0xee, 0x93, .3),
      300: Color.fromRGBO(0xff, 0xee, 0x93, .4),
      400: Color.fromRGBO(0xff, 0xee, 0x93, .5),
      500: Color.fromRGBO(0xff, 0xee, 0x93, .6),
      600: Color.fromRGBO(0xff, 0xee, 0x93, .7),
      700: Color.fromRGBO(0xff, 0xee, 0x93, .8),
      800: Color.fromRGBO(0xff, 0xee, 0x93, .9),
      900: Color.fromRGBO(0xff, 0xee, 0x93, 1),
    }
);

const MaterialColor foregroundBlue = MaterialColor(0xff79addc,
    {
      50: Color.fromRGBO(0x79, 0xad, 0xdc, .1),
      100: Color.fromRGBO(0x79, 0xad, 0xdc, .2),
      200: Color.fromRGBO(0x79, 0xad, 0xdc, .3),
      300: Color.fromRGBO(0x79, 0xad, 0xdc, .4),
      400: Color.fromRGBO(0x79, 0xad, 0xdc, .5),
      500: Color.fromRGBO(0x79, 0xad, 0xdc, .6),
      600: Color.fromRGBO(0x79, 0xad, 0xdc, .7),
      700: Color.fromRGBO(0x79, 0xad, 0xdc, .8),
      800: Color.fromRGBO(0x79, 0xad, 0xdc, .9),
      900: Color.fromRGBO(0x79, 0xad, 0xdc, 1),
    }
);

const MaterialColor buttonOrange = MaterialColor(0xffffc09f,
    {
      50: Color.fromRGBO(0xff, 0xc0, 0x9f, .1),
      100: Color.fromRGBO(0xff, 0xc0, 0x9f, .2),
      200: Color.fromRGBO(0xff, 0xc0, 0x9f, .3),
      300: Color.fromRGBO(0xff, 0xc0, 0x9f, .4),
      400: Color.fromRGBO(0xff, 0xc0, 0x9f, .5),
      500: Color.fromRGBO(0xff, 0xc0, 0x9f, .6),
      600: Color.fromRGBO(0xff, 0xc0, 0x9f, .7),
      700: Color.fromRGBO(0xff, 0xc0, 0x9f, .8),
      800: Color.fromRGBO(0xff, 0xc0, 0x9f, .9),
      900: Color.fromRGBO(0xff, 0xc0, 0x9f, 1),
    }
);

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Macondo'),
      home: const MyHomePage(title: 'My Time')
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundYellow,
      body: Column(
        children: [
          Container(
            width: 410,
            height: 170,
            child: LayoutBuilder(
                builder: (_, constraints) => Container(
                    width: constraints.widthConstraints().maxWidth,
                    height: constraints.heightConstraints().maxHeight,
                    child: CustomPaint(painter: TopCirclesPainter())
                )
            )
          ),
          const Text(appName, style: TextStyle(fontSize: 75)),
          const SizedBox(
            width: 240,
            child: Text(appNameSubText, style: TextStyle(fontSize: 45, color: foregroundBlue)),
          ),
          Form(child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  style: const TextStyle(fontSize: 25.0),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: foregroundBlue[600],
                    hintText: emailTextBoxHint,
                    contentPadding: const EdgeInsets.only(
                        left: 24.0, bottom: 18.0, top: 18.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromRGBO(0xff, 0xee, 0x93, .7),),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromRGBO(0xff, 0xee, 0x93, .7),),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              ElevatedButton(onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffffc09f),
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  )
                ),
                child: const Text(homeEnterButtonText,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black
                    )
                ),
              )
            ],
          )),
          CircleWithSvg()
        ],
      )
    );
  }
}

class TopCirclesPainter extends CustomPainter {
  final double circleWidth = 120;

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0x8079addc)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(80, 0), circleWidth, paint1);
    canvas.drawCircle(const Offset(0, 70), circleWidth, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Since painted elements are not mutable, can return false
    return false;
  }
}

class CircleWithSvg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String assetName = 'images/undraw_completed_5jdt.svg';
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: CustomPaint(
            painter: CirclePainter(),
          ),
        ),
        Transform.translate(
          offset: const Offset(140, 30),
          child: SizedBox(
            width: 200,
            height: 140,
            child: SvgPicture.asset(assetName),
          )
        ),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = const Color(0x8079addc);

    canvas.drawCircle(
      Offset(size.width + 50, size.height - 20),
      size.width + 20,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
