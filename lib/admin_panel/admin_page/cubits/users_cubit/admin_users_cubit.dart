import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'admin_users_state.dart';

class AdminUsersCubit extends Cubit<AdminUsersState> {
  AdminUsersCubit({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(const AdminInitial());

  final FirestoreRepository _firestoreRepository;
  late final StreamSubscription<dynamic> _userListSubscription;
  UserDataModel? _shadowUser;

  Future<void> init() async {
    emit(const AdminFetchingUsers());
    try {
      final subscriptions = await _firestoreRepository.getSubscriptionTypes();
      _userListSubscription =
          _firestoreRepository.listenUserList().listen((snapshots) {
        final users = snapshots.docs
            .map(
              (e) => UserDataModel.fromMap(e.data()),
            )
            .toList();
        UserDataModel? user;
        if (state is AdminUsersFetched) {
          final shadowState = state as AdminUsersFetched;
          user = shadowState.user;
          if (user != null) {
            _shadowUser = user;
            user = users.firstWhere(
              (element) => element.authId == user!.authId,
              orElse: () => user!,
            );
          }
        }
        emit(
          AdminUsersFetched(
            users: users,
            user: user,
            subscriptions: subscriptions,
          ),
        );
      });
    } catch (_) {
      emit(const AdminUsersError());
    }
  }

  Future<void> selectUser(String userId) async {
    if (state is! AdminUsersFetched) return;
    final shadowState = state as AdminUsersFetched;
    final user = shadowState.users.firstWhere(
      (element) => element.authId == userId,
    );
    _shadowUser = user;
    emit(shadowState.copyWith(user: user));
  }

  void updateSelectedUser(UserDataModel user) {
    if (state is! AdminUsersFetched) return;
    final shadowState = state as AdminUsersFetched;
    emit(AdminFetchingUsers(subscriptions: state.subscriptions));
    final users = shadowState.users.map((e) {
      if (e.authId == user.authId) {
        return user;
      }
      return e;
    }).toList();
    emit(shadowState.copyWith(users: users, user: user));
  }

  bool get isUserUpdated {
    if (state is! AdminUsersFetched) return false;
    final shadowState = state as AdminUsersFetched;
    if (_shadowUser == null) return false;
    if (shadowState.user == null) return false;
    return shadowState.user != _shadowUser;
  }

  void clearUser() {
    if (state is! AdminUsersFetched) return;
    final shadowState = state as AdminUsersFetched;
    emit(shadowState.copyWith(user: _shadowUser));
  }

  void unSelectUser() {
    if (state is! AdminUsersFetched) return;
    final shadowState = state as AdminUsersFetched;
    emit(AdminFetchingUsers(subscriptions: state.subscriptions));
    _shadowUser = null;
    emit(
      AdminUsersFetched(
        users: shadowState.users,
        subscriptions: state.subscriptions,
      ),
    );
  }

  Future<void> updateUser() async {
    if (state is! AdminUsersFetched) return;
    final shadowState = state as AdminUsersFetched;
    final user = shadowState.user;
    if (user == null) return;
    try {
      emit(shadowState.copyWith(isUpdating: true, user: user));
      await _firestoreRepository.updateUser(user.toMap(), user.id!);
      _shadowUser = user;
      emit(shadowState.copyWith(user: user));
    } catch (_) {
      emit(shadowState.copyWith(user: _shadowUser));
    }
  }

  Future<void> markUserAsRead({required UserDataModel user}) async {
    if (state is! AdminUsersFetched) return;
    if (user.isRead) return;
    try {
      final shadowState = state as AdminUsersFetched;
      final updated = user.copyWith(isRead: true);
      final users = shadowState.users.map((e) {
        if (e.authId == user.authId) {
          return updated;
        }
        return e;
      }).toList();
      _shadowUser = updated;
      emit(shadowState.copyWith(users: users, user: updated));
      await _firestoreRepository.updateUser(
        updated.toMap(),
        user.id!,
      );
    } catch (_) {}
  }

  Future<void> markUserAsUnread() async {
    if (state is! AdminUsersFetched) return;
    try {
      final shadowState = state as AdminUsersFetched;
      final user = shadowState.user;
      if (user == null) return;
      final updated = user.copyWith(isRead: false);
      final users = shadowState.users.map((e) {
        if (e.authId == user.authId) {
          return updated;
        }
        return e;
      }).toList();
      emit(shadowState.copyWith(users: users, user: updated));
      _shadowUser = updated;
      await _firestoreRepository.updateUser(
        updated.toMap(),
        user.id!,
      );
    } catch (_) {}
  }

  Future<void> deleteUser() async {
    if (state is! AdminUsersFetched) return;
    try {
      final shadowState = state as AdminUsersFetched;
      final user = shadowState.user;
      if (user == null) return;
      await _firestoreRepository.deleteUser(user.id!);
      final users = shadowState.users.where((e) => e.id != user.id);
      _shadowUser = null;
      emit(shadowState.copyWith(users: users.toList()));
    } catch (_) {}
  }

  Subscription? get userSubscription {
    if (state is! AdminUsersFetched) return null;
    final shadowState = state as AdminUsersFetched;
    final user = shadowState.user;
    if (user == null) return null;
    try {
      return shadowState.subscriptions?.firstWhere(
        (element) => element.name == user.subscription,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> close() {
    _userListSubscription.cancel();
    return super.close();
  }
}
