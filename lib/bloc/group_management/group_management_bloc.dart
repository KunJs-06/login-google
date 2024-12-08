import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'group_management_event.dart';
part 'group_management_state.dart';

class GroupManagementBloc extends Bloc<GroupManagementEvent, GroupManagementState> {
  GroupManagementBloc() : super(GroupManagementInitial()) {
    on<GroupManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
