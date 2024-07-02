part of 'search_contact_cubit.dart';


enum SearchContactStatus {
  initial, loading, success, error
}

class SearchContactState {

  final SearchContactStatus status;
  List<CustodiedWalletsInfoResponse>? customerCustWalletList;
  List<User>? userList;
  final String errorMessage;

  SearchContactState({
    this.status = SearchContactStatus.initial,
    this.userList,
    this.customerCustWalletList,
    this.errorMessage = ""
  });


  SearchContactState copyWith({
    String? errorMessage,
    List<User>? userList,
    List<CustodiedWalletsInfoResponse>? customerCustWalletList,
    SearchContactStatus? status
  }) {
    return SearchContactState(
        userList: userList ?? this.userList,
        customerCustWalletList: customerCustWalletList ?? this.customerCustWalletList,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
