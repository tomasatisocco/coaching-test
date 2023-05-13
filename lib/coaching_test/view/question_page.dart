import 'package:coaching/coaching_test/cubit/coaching_test_cubit.dart';
import 'package:coaching/coaching_test/models/question_model.dart';
import 'package:coaching/coaching_test/widgets/next_question_button.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({
    super.key,
    required this.question,
    required this.pageController,
    required this.onCompleted,
  });

  final QuestionModel question;
  final PageController pageController;
  final Future<void> Function(String key, int value) onCompleted;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _selectedValue = 0;

  @override
  void initState() {
    super.initState();
    final initialValue = context.read<CoachingTestCubit>().getInitialValue(
              widget.question.key,
            ) ~/
        widget.question.multiplier;
    setState(() {
      _selectedValue = initialValue;
    });
  }

  Future<void> onComplete() async {
    final value = widget.question.answers(context.l10n).values.elementAt(
          _selectedValue,
        );

    await widget.onCompleted(widget.question.key, value);
    if (widget.question.key == '404') return;
    await widget.pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  Future<void> onBackPress() async {
    await widget.pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  Future<void> onTabPress() async {
    if (_selectedValue == widget.question.answers(context.l10n).length - 1) {
      setState(() {
        _selectedValue = 0;
      });
      return;
    }
    setState(() {
      _selectedValue = _selectedValue + 1;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(
        onKey: (node, event) => KeyEventResult.handled,
      ),
      autofocus: true,
      onKey: (value) async {
        if (value.runtimeType != RawKeyDownEvent) return;
        if (value.logicalKey == LogicalKeyboardKey.enter) return onComplete();
        if (value.logicalKey == LogicalKeyboardKey.tab) return onTabPress();
      },
      child: ResponsiveBuilder(builder: (context, sizingInformation) {
        if (sizingInformation.isMobile || sizingInformation.isTablet) {
          return QuestionPageMobileView(
            question: widget.question,
            selectedValue: _selectedValue,
            onBackPress: onBackPress,
            onCompleted: onComplete,
            onSelectedValue: (value) {
              setState(() {
                _selectedValue = value;
              });
            },
          );
        }
        return QuestionPageDesktopView(
          question: widget.question,
          selectedValue: _selectedValue,
          onBackPress: onBackPress,
          onCompleted: onComplete,
          onSelectedValue: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        );
      }),
    );
  }
}

class QuestionPageMobileView extends StatelessWidget {
  const QuestionPageMobileView({
    super.key,
    required this.question,
    required this.selectedValue,
    required this.onBackPress,
    required this.onCompleted,
    required this.onSelectedValue,
  });

  final QuestionModel question;
  final int selectedValue;
  final Future<void> Function() onCompleted;
  final Future<void> Function() onBackPress;
  final void Function(int value) onSelectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(64),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  question.getQuestion(context.l10n),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF2FA0F3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  question.getDescription(context.l10n),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2FA0F3),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: question.answers(context.l10n).length * 32,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ListView.builder(
                    itemCount: question.answers(context.l10n).length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: RadioListTile(
                            value: index,
                            groupValue: selectedValue,
                            dense: true,
                            onChanged: (value) => onSelectedValue(value ?? 0),
                            contentPadding: const EdgeInsets.all(4),
                            title: Text(
                              // ignore: lines_longer_than_80_chars
                              '${lettersMap[index] ?? ''} - ${question.answers(context.l10n).keys.elementAt(index)}',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                NextQuestionButton(
                  onCompleted: onCompleted,
                  onBackPress: onBackPress,
                  questionKey: question.key,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionPageDesktopView extends StatelessWidget {
  const QuestionPageDesktopView({
    super.key,
    required this.question,
    required this.selectedValue,
    required this.onBackPress,
    required this.onCompleted,
    required this.onSelectedValue,
  });

  final QuestionModel question;
  final int selectedValue;
  final Future<void> Function() onCompleted;
  final Future<void> Function() onBackPress;
  final void Function(int value) onSelectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2FA0F3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        question.getQuestion(context.l10n),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        question.getDescription(context.l10n),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          'assets/images/question.jpg',
                          width: MediaQuery.of(context).size.width * 0.4 >= 500
                              ? 500
                              : MediaQuery.of(context).size.width * 0.4,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 400,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ListView.builder(
                              itemCount: question.answers(context.l10n).length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: RadioListTile(
                                      value: index,
                                      groupValue: selectedValue,
                                      onChanged: (value) =>
                                          onSelectedValue(value ?? 0),
                                      contentPadding: const EdgeInsets.all(4),
                                      title: Text(
                                        // ignore: lines_longer_than_80_chars
                                        '${lettersMap[index] ?? ''} - ${question.answers(context.l10n).keys.elementAt(index)}',
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Spacer(),
                          NextQuestionButton(
                            onCompleted: onCompleted,
                            onBackPress: onBackPress,
                            questionKey: question.key,
                            isMobile: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Map<int, String> lettersMap = {
  0: 'a',
  1: 'b',
  2: 'c',
  3: 'd',
  4: 'e',
  5: 'f',
  6: 'g',
};
