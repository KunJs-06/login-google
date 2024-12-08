part of 'group_management_bloc.dart';

sealed class GroupManagementState extends Equatable {
  const GroupManagementState();
}

final class GroupManagementInitial extends GroupManagementState {
  @override
  List<Object> get props => [];
}
