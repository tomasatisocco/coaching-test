import 'package:flutter/material.dart';

class TestProgressBar extends StatelessWidget {
  const TestProgressBar({
    super.key,
    required this.currentPageIndex,
    this.isWeb = false,
  });

  final int currentPageIndex;
  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isWeb
        ? Theme.of(context).colorScheme.inversePrimary
        : Theme.of(context).colorScheme.onSecondary;
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 25,
        controller: ScrollController(
          initialScrollOffset: currentPageIndex >= 18
              ? currentPageIndex * 32.0
              : currentPageIndex * 12,
        ),
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: backgroundColor,
                width: isWeb ? MediaQuery.of(context).size.width / 24 : 48,
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  width: index == currentPageIndex ? 48 : 32,
                  decoration: BoxDecoration(
                    color: index == currentPageIndex
                        ? Theme.of(context).colorScheme.primary
                        : backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: index == currentPageIndex
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.secondary,
                        fontSize: index == currentPageIndex ? 24 : 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
