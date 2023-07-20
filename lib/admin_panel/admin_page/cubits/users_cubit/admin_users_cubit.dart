import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'admin_users_state.dart';

class AdminUsersCubit extends Cubit<AdminUsersState> {
  AdminUsersCubit({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(AdminInitial());

  final FirestoreRepository _firestoreRepository;
  late final StreamSubscription<dynamic> _userListSubscription;

  Future<void> init() async {
    emit(AdminFetchingUsers());
    try {
      _userListSubscription =
          _firestoreRepository.listenUserList().listen((snapshots) {
        final users = snapshots.docs
            .map(
              (e) => UserDataModel.fromMap(e.data()).copyWith(authId: e.id),
            )
            .toList();
        emit(AdminUsersFetched(users: users));
      });
    } catch (_) {
      emit(AdminUsersError());
    }
  }

  @override
  Future<void> close() {
    _userListSubscription.cancel();
    return super.close();
  }
}
