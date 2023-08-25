part of 'mp_authorized_cubit.dart';

class MpAuthorizedState extends Equatable {
  const MpAuthorizedState();

  @override
  List<Object> get props => [];
}

class MpAuthorizedInitial extends MpAuthorizedState {
  const MpAuthorizedInitial();
}

class MpAuthorizedLoading extends MpAuthorizedState {
  const MpAuthorizedLoading();
}

class MpAuthorizedSuccess extends MpAuthorizedState {
  const MpAuthorizedSuccess();
}

class MpAuthorizedFailure extends MpAuthorizedState {
  const MpAuthorizedFailure();
}
