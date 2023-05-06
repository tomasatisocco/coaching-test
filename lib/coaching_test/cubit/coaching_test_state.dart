part of 'coaching_test_cubit.dart';

@immutable
abstract class CoachingTestState {
  const CoachingTestState(this.testModel);

  final CoachingTest testModel;

  List<Object> get props => [testModel];
}

class CoachingTestInitial extends CoachingTestState {
  const CoachingTestInitial(super.testModel);
}

class CoachingTestUpdating extends CoachingTestState {
  const CoachingTestUpdating(super.testModel);
}

class CoachingTestUpdated extends CoachingTestState {
  const CoachingTestUpdated(super.testModel);
}

class CoachingTestSuccess extends CoachingTestState {
  const CoachingTestSuccess(super.testModel);
}

class CoachingTestError extends CoachingTestState {
  const CoachingTestError(super.testModel);
}
