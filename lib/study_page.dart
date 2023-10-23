import 'package:flutter/material.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({super.key});

  @override
  State createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StudyTestWidget(color: Colors.yellow),
        const StudyTestWidget(color: Colors.red),
        const StudyTestWidget(color: Colors.green),

        // Container(width: 100, height: 100, color: Colors.red),
        // Container(width: 100, height: 100, color: Colors.green),
      ],
    );
  }
}

class StudyTestWidget extends StatefulWidget {
  final Color color;

  const StudyTestWidget({super.key, required this.color});

  @override
  State createState() => _StudyTestWidgetState();
}

class _StudyTestWidgetState extends State<StudyTestWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(width: 100, height: 100, color: widget.color);
  }
}
