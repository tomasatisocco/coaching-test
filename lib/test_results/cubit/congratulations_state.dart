part of 'congratulations_cubit.dart';

abstract class CongratulationsState extends Equatable {
  const CongratulationsState({this.isPaid = false});

  final bool isPaid;

  CongratulationsState copyWith({required bool isPaid});

  // props
  @override
  List<Object?> get props => [isPaid];
}

class CongratulationsInitial extends CongratulationsState {
  const CongratulationsInitial({bool? isPaid}) : super(isPaid: isPaid ?? false);

  @override
  CongratulationsState copyWith({required bool isPaid}) {
    return CongratulationsInitial(isPaid: isPaid);
  }
}

class CongratulationsLoading extends CongratulationsState {
  const CongratulationsLoading({bool? isPaid}) : super(isPaid: isPaid ?? false);

  @override
  CongratulationsState copyWith({required bool isPaid}) {
    return CongratulationsLoading(isPaid: isPaid);
  }
}

class CongratulationsSuccess extends CongratulationsState {
  const CongratulationsSuccess({bool? isPaid}) : super(isPaid: isPaid ?? false);

  @override
  CongratulationsState copyWith({required bool isPaid}) {
    return CongratulationsSuccess(isPaid: isPaid);
  }
}

class CongratulationsFailure extends CongratulationsState {
  const CongratulationsFailure({bool? isPaid}) : super(isPaid: isPaid ?? false);

  @override
  CongratulationsState copyWith({required bool isPaid}) {
    return CongratulationsFailure(isPaid: isPaid);
  }
}
