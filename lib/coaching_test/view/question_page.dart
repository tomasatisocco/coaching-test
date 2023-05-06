import 'package:coaching/coaching_test/cubit/coaching_test_cubit.dart';
import 'package:coaching/coaching_test/models/question_model.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  int? _selectedValue = 0;
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode(
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          if (_selectedValue == null) return KeyEventResult.handled;

          final value = widget.question.answers.values.elementAt(
            _selectedValue!,
          );

          widget.onCompleted(widget.question.key, value);
          if (widget.question.key == '404') return KeyEventResult.handled;
          widget.pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        }
        if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
          if (_selectedValue == null) return KeyEventResult.handled;
          if (_selectedValue == widget.question.answers.length - 1) {
            setState(() {
              _selectedValue = 0;
            });
            return KeyEventResult.handled;
          }
          setState(() {
            _selectedValue = _selectedValue! + 1;
          });
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        body: Padding(
          padding: const EdgeInsets.all(24),
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
                      widget.question.question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.question.description,
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
                    SizedBox(
                      height: 500,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset('images/question.jpg'),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 400,
                          width: 600,
                          child: ListView.builder(
                            itemCount: widget.question.answers.length,
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
                                    groupValue: _selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedValue = value;
                                      });
                                    },
                                    contentPadding: const EdgeInsets.all(4),
                                    title: Text(
                                      '${lettersMap[index] ?? ''} - ${widget.question.answers.keys.elementAt(index)}',
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

                            final value =
                                widget.question.answers.values.elementAt(
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
                                width: 320,
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
                                duration: const Duration(milliseconds: 300),
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
