import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Fab(),
    );
  }
}

class Fab extends StatefulWidget {
  Fab();

  @override
  _FabState createState() => _FabState();
}

class _FabState extends State<Fab>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  bool isOpened = false;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_animationController);
    _translateButton = Tween<double>(
      begin: 0.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: Curves.easeOutBack
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward().orCancel;
    } else {
      _animationController.reverse().orCancel;
    }
    isOpened = !isOpened;
  }

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget image() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Image',
        child: Icon(Icons.image),
      ),
    );
  }

  Widget inbox() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Inbox',
        child: Icon(Icons.inbox),
      ),
    );
  }

  Widget menu() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Menu',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Stack(children: [
      Positioned(
        right: 30,
        bottom: 30,
      child:Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(270), _translateButton.value*100),
          child: add(),
        ),
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(225), _translateButton.value*100),
          child: image(),
        ),
        Transform.translate(
          offset: Offset.fromDirection(getRadiansFromDegree(180), _translateButton.value*100),
          child: inbox(),
        ),
        menu(),
      ],
    ))]));
  }
}