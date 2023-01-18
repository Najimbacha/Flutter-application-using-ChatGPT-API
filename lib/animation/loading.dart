import 'package:flutter/material.dart';

class ThreeDotLoadingIndicator extends StatefulWidget {
  const ThreeDotLoadingIndicator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThreeDotLoadingIndicatorState createState() =>
      _ThreeDotLoadingIndicatorState();
}

class _ThreeDotLoadingIndicatorState extends State<ThreeDotLoadingIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _dotCount++;
        if (_dotCount > 2) {
          _dotCount = 0;
        }
        _animationController!.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController!.forward();
      }
    });
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text("Typing"),
          const SizedBox(
            width: 8,
          ),
          FadeTransition(
            opacity: _animationController!,
            child: const Icon(Icons.lens,
                size: 8, color: Color.fromARGB(255, 162, 190, 212)),
          ),
          const SizedBox(width: 5),
          FadeTransition(
            opacity: _animationController!.drive(Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: const Interval(0.1, 1.0)))),
            child: const Icon(Icons.lens,
                size: 8, color: Color.fromARGB(255, 125, 134, 125)),
          ),
          const SizedBox(width: 5),
          FadeTransition(
            opacity: _animationController!.drive(Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: const Interval(0.2, 1.0)))),
            child: const Icon(Icons.lens,
                size: 8, color: Color.fromARGB(255, 201, 158, 158)),
          ),
          const SizedBox(width: 5),
          FadeTransition(
            opacity: _animationController!.drive(Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: const Interval(0.2, 1.0)))),
            child: const Icon(Icons.lens, size: 8, color: Colors.amber),
          ),
        ],
      ),
    );
  }
}
