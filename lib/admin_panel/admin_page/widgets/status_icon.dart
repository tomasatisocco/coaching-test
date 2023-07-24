import 'package:flutter/material.dart';

class StatusIcon extends StatelessWidget {
  const StatusIcon({
    super.key,
    required this.icon,
    required this.title,
    this.isDone = false,
  });

  final IconData icon;
  final String title;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            Visibility(
              visible: isDone,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: const Icon(
                Icons.check_rounded,
                color: Colors.green,
              ),
            ),
            Icon(
              icon,
              color: isDone ? Colors.blue : Colors.grey,
              size: 30,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
