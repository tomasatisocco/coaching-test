import 'package:coaching/coaching_test/cubit/coaching_test_cubit.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextQuestionButton extends StatelessWidget {
  const NextQuestionButton({
    super.key,
    required this.onCompleted,
    required this.onBackPress,
    required this.questionKey,
    this.isMobile = true,
  });

  final Future<void> Function() onCompleted;
  final Future<void> Function() onBackPress;
  final bool isMobile;
  final String questionKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onCompleted,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA6FAAC),
          ),
          child: BlocBuilder<CoachingTestCubit, CoachingTestState>(
            builder: (context, state) {
              return Container(
                width: isMobile ? 160 : 320,
                padding: const EdgeInsets.all(8),
                child: state is CoachingTestUpdating
                    ? const SizedBox(
                        height: 32,
                        width: 32,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Text(
                        questionKey == '404'
                            ? context.l10n.complete
                            : context.l10n.next,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 24 : 32,
                          color: Colors.black,
                        ),
                      ),
              );
            },
          ),
        ),
        Visibility(
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          visible: questionKey != '101',
          child: TextButton(
            onPressed: onBackPress,
            child: Text(
              context.l10n.previous,
              style: TextStyle(
                fontSize: isMobile ? 12 : 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
