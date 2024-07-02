part of 'user_contact_cubit.dart';


enum UserContactStatus {
  initial, loading, success, error
}

class UserContactState {

  final UserContactStatus status;
  List<UserContact>? userContactList;
  final String errorMessage;

  UserContactState({
    this.status = UserContactStatus.initial,
    this.userContactList,
    this.errorMessage = ""
  });


  UserContactState copyWith({
    String? errorMessage,
    List<UserContact>? userContactList,
    UserContactStatus? status
  }) {
    return UserContactState(
        userContactList: userContactList ?? this.userContactList,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
