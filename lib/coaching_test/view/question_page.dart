import 'package:coaching/coaching_test/cubit/coaching_test_cubit.dart';
import 'package:coaching/coaching_test/models/test_model.dart';
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
  final void Function(String key, int value) onCompleted;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int? _selectedValue;

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

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(
        onKey: (node, event) => KeyEventResult.handled,
      ),
      autofocus: true,
      onKey: (value) {
        if (value.runtimeType != RawKeyDownEvent) return;
        if (value.logicalKey == LogicalKeyboardKey.enter) {
          if (_selectedValue == null) return;

          final value = widget.question.answers(context.l10n).values.elementAt(
                _selectedValue!,
              );

          widget.onCompleted(widget.question.key, value);
          if (widget.question.key == '404') return;
          widget.pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        }
        if (value.logicalKey == LogicalKeyboardKey.tab) {
          if (_selectedValue == null) return;
          if (_selectedValue ==
              widget.question.answers(context.l10n).length - 1) {
            setState(() {
              _selectedValue = 0;
            });
            return;
          }
          setState(() {
            _selectedValue = _selectedValue! + 1;
          });
          return;
        }
        return;
      },
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.isMobile || sizingInformation.isTablet) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(64),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          widget.question.getQuestion(context.l10n),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF2FA0F3),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 400,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ListView.builder(
                            itemCount:
                                widget.question.answers(context.l10n).length,
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
                                    groupValue: _selectedValue,
                                    dense: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedValue = value;
                                      });
                                    },
                                    contentPadding: const EdgeInsets.all(4),
                                    title: Text(
                                      '${lettersMap[index] ?? ''} - ${widget.question.answers(context.l10n).keys.elementAt(index)}',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if (_selectedValue == null) return;

                            final value = widget.question
                                .answers(context.l10n)
                                .values
                                .elementAt(
                                  _selectedValue!,
                                );

                            widget.onCompleted(widget.question.key, value);
                            if (widget.question.key == '404') return;
                            widget.pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA6FAAC),
                          ),
                          child:
                              BlocBuilder<CoachingTestCubit, CoachingTestState>(
                            builder: (context, state) {
                              return Container(
                                width: 160,
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
                                        widget.question.key == '404'
                                            ? context.l10n.complete
                                            : context.l10n.next,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 24,
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
                          visible: widget.question.key != '101',
                          child: TextButton(
                            child: Text(
                              context.l10n.previous,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              widget.pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
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
                              widget.question.getQuestion(context.l10n),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.question.getDescription(context.l10n),
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
                                width: MediaQuery.of(context).size.width *
                                            0.4 >=
                                        500
                                    ? 500
                                    : MediaQuery.of(context).size.width * 0.4,
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 400,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: ListView.builder(
                                    itemCount: widget.question
                                        .answers(context.l10n)
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          child: RadioListTile(
                                            value: index,
                                            groupValue: _selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedValue = value;
                                              });
                                            },
                                            contentPadding:
                                                const EdgeInsets.all(4),
                                            title: Text(
                                              '${lettersMap[index] ?? ''} - ${widget.question.answers(context.l10n).keys.elementAt(index)}',
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_selectedValue == null) return;

                                    final value = widget.question
                                        .answers(context.l10n)
                                        .values
                                        .elementAt(
                                          _selectedValue!,
                                        );

                                    widget.onCompleted(
                                        widget.question.key, value);
                                    if (widget.question.key == '404') return;
                                    widget.pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFA6FAAC),
                                  ),
                                  child: BlocBuilder<CoachingTestCubit,
                                      CoachingTestState>(
                                    builder: (context, state) {
                                      return Container(
                                        width: 320,
                                        padding: const EdgeInsets.all(8),
                                        child: state is CoachingTestUpdating
                                            ? const SizedBox(
                                                height: 32,
                                                width: 32,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              )
                                            : Text(
                                                widget.question.key == '404'
                                                    ? context.l10n.complete
                                                    : context.l10n.next,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 32,
                                                  color: Colors.black,
                                                ),
                                              ),
                                      );
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: widget.question.key != '101',
                                  child: TextButton(
                                    child: Text(
                                      context.l10n.previous,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      widget.pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.linear,
                                      );
                                    },
                                  ),
                                )
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
        },
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
