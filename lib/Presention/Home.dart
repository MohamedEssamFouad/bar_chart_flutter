import 'package:bar_chart_flutter/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../ChartsData.dart';
import '../Model/BarData.dart';

class AnimatedChartScreen extends HookWidget {
  final List<BarData> data;

  const AnimatedChartScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: const Duration(seconds: 5));
    final animation = useAnimation(
      Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut)),
    );

    final touchedIndex = useState<int?>(-1);

    useEffect(() {
      animationController.forward();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('Animated Charts')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Merchandising Report',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'This report provides an overview of merchandising performance across different categories.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ChartsWidget(
                data: data,
                animation: animation,
                touchedIndex: touchedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
