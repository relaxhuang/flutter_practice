import 'package:flutter/material.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_app/main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).pushNamed(LoginScreen.tag);
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LottieAnimate(
      frameBuilder: (context, child, composition) {
        return Transform.scale(
          scale: 1,
          child: Container(
            color: Colors.white,
            child: child,
          ),
        );
      },
    );
  }
}

class LottieAnimate extends StatelessWidget {
  final Function frameBuilder;
  const LottieAnimate({Key key, this.frameBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _SplashPageState state = context.findAncestorStateOfType();
    return Lottie.asset('assets/lottie/splash.json',
        repeat: false, controller: state._controller, onLoaded: (composition) {
      state._controller
        ..duration = composition.duration
        ..forward();
    });
  }
}
