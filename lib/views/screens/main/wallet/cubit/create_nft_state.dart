part of 'create_nft_cubit.dart';


enum CreateNftStatus {
  initial, loading, walletCreated, success, error
}

class CreateNftState {

  final CreateNftStatus status;
  DeployedSCResponseModel? deployedSCResponseModel;
  UserNfTsModel? selectedUserNftModel;
  List<PlatformFile>? selectedFile;

  CreateNftState({
    this.status = CreateNftStatus.initial,
    this.deployedSCResponseModel,
    this.selectedFile,
    this.selectedUserNftModel
  });

  CreateNftState copyWith({
    DeployedSCResponseModel? deployedSCResponseModel,
    UserNfTsModel? selectedUserNftModel,
    List<PlatformFile>? selectedFile,
    CreateNftStatus? status
  }) {
    return CreateNftState(
        status: status ?? this.status,
        deployedSCResponseModel: deployedSCResponseModel ?? this.deployedSCResponseModel,
        selectedUserNftModel: selectedUserNftModel ?? this.selectedUserNftModel,
        selectedFile: selectedFile ?? this.selectedFile,
    );
  }
}
