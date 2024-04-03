import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

/// BallClipRotatePulse widget displays the loading indicator whenever the api is loading.
class BallClipRotatePulse extends StatelessWidget {
  const BallClipRotatePulse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: LoadingIndicator(
        indicatorType: Indicator.ballClipRotatePulse,
        colors: [Colors.orange, Colors.white],
      ),
    );
  }
}
