import 'package:coaching/app/widgets/language_switch_widget.dart';
import 'package:coaching/coaching_test/cubit/coaching_test_cubit.dart';
import 'package:coaching/coaching_test/models/question_model.dart';
import 'package:coaching/coaching_test/widgets/next_question_button.dart';
import 'package:coaching/coaching_test/widgets/test_progress_bar.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/remote_configs.dart';
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
    required this.currentPageIndex,
  });

  final QuestionModel question;
  final PageController pageController;
  final Future<void> Function(String key, int value) onCompleted;
  final int currentPageIndex;

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
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutQuart,
    );
  }

  Future<void> onBackPress() async {
    await widget.pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutQuart,
    );
  }

  Future<void> onTabPress() async {
    if (_selectedValue == widget.question.answers(context.l10n).length - 1) {
      setState(() {
        _selectedValue = 0;
      });
      return;
    }
    final newValue = _selectedValue + 1;
    setState(() {
      _selectedValue = newValue;
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
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.isMobile || sizingInformation.isTablet) {
            return QuestionPageMobileView(
              question: widget.question,
              selectedValue: _selectedValue,
              onBackPress: onBackPress,
              onCompleted: onComplete,
              currentPageIndex: widget.currentPageIndex,
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
            currentPageIndex: widget.currentPageIndex,
            onSelectedValue: (value) {
              setState(() {
                _selectedValue = value;
              });
            },
          );
        },
      ),
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
    required this.currentPageIndex,
  });

  final QuestionModel question;
  final int selectedValue;
  final Future<void> Function() onCompleted;
  final Future<void> Function() onBackPress;
  final void Function(int value) onSelectedValue;
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 32,
        actions: const [
          LanguageSwitch(),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          TestProgressBar(currentPageIndex: currentPageIndex),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              height: MediaQuery.sizeOf(context).height - 130,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question.getDescription(
                        context.l10n,
                        context.read<RemoteConfigurations>(),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: question.answers(context.l10n).length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: RadioListTile(
                                value: index,
                                groupValue: selectedValue,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                dense: true,
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
                    const SizedBox(height: 8),
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
        ],
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
    required this.currentPageIndex,
  });

  final QuestionModel question;
  final int selectedValue;
  final Future<void> Function() onCompleted;
  final Future<void> Function() onBackPress;
  final void Function(int value) onSelectedValue;
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 32,
        actions: const [
          LanguageSwitch(),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TestProgressBar(
                currentPageIndex: currentPageIndex,
                isWeb: true,
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                color: Theme.of(context).colorScheme.primary,
                child: Column(
                  children: [
                    Text(
                      question.getQuestion(context.l10n),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question.getDescription(
                        context.l10n,
                        context.read<RemoteConfigurations>(),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        question.questionImage,
                        width: MediaQuery.of(context).size.width * 0.4 >= 500
                            ? 500
                            : MediaQuery.of(context).size.width * 0.4,
                      ),
                    ),
                    Column(
                      children: [
                        const Spacer(flex: 2),
                        // TODO: Abstract this calculation
                        SizedBox(
                          height: MediaQuery.of(context).size.height *
                                      0.15 *
                                      question.answers(context.l10n).length >
                                  MediaQuery.of(context).size.height * 0.45
                              ? MediaQuery.of(context).size.height * 0.45
                              : MediaQuery.of(context).size.height *
                                  0.15 *
                                  question.answers(context.l10n).length,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ListView.builder(
                            itemCount: question.answers(context.l10n).length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: RadioListTile(
                                    value: index,
                                    groupValue: selectedValue,
                                    activeColor:
                                        Theme.of(context).colorScheme.primary,
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
                        const SizedBox(
                          height: 10,
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
  7: 'h',
};
