import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:functions_repository/functions_repository.dart';

part 'mp_authorized_state.dart';

class MpAuthorizedCubit extends Cubit<MpAuthorizedState> {
  MpAuthorizedCubit({
    required this.code,
    required this.identifier,
    required FunctionsRepository functionsRepository,
  })  : _functionsRepository = functionsRepository,
        super(const MpAuthorizedInitial());

  final String code;
  final String identifier;
  final FunctionsRepository _functionsRepository;

  Future<void> authorize() async {
    emit(const MpAuthorizedLoading());
    await _functionsRepository.call(
      parameters: {
        'code': code,
        'state': identifier,
      },
    );
    emit(const MpAuthorizedSuccess());
  }
}
