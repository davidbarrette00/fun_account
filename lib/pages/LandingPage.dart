import 'package:flutter/material.dart' show Placeholder, State, StatefulWidget, BuildContext, Widget, MediaQuery;

class LandingPage extends StatefulWidget {
  final String title;

  const LandingPage({super.key,  required this.title});

  @override
  State<LandingPage> createState() => _LandingpageState();
}

class _LandingpageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var windowWidth = MediaQuery.of(context).size.width;
    var windowHeight = MediaQuery.of(context).size.height;

    return const Placeholder();

  }
}
