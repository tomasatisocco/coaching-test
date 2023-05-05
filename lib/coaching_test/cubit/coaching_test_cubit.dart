import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'coaching_test_state.dart';

class CoachingTestCubit extends Cubit<CoachingTestState> {
  CoachingTestCubit() : super(CoachingTestInitial());
}
