import 'dart:convert';

import 'package:social_wallet/models/bc_networks_model.dart';
import 'package:social_wallet/models/db/user.dart';
import 'package:social_wallet/utils/helpers/typedefs.dart';

import '../../models/owned_token_account_info_model.dart';
import 'key_value_storage_base.dart';


class KeyValueStorageService {

  static const _isMainnetEnabled = 'isMainnetEnabled';
  static const _showAgainDeleteNotificationDialog = 'showAgainDeleteNotificationDialog';
  static const _hasEnterAddAppointmentScreen = 'hasEnterAddAppointmentScreen';
  static const _isUserRegistered = 'isUserRegistered';
  static const _token = 'token';
  static const _networkInfo = 'networkInfo';
  static const _userAddress = 'userAddress';
  static const _userModel = 'userModel';
  static const _getOwnedTokenAccountInfoModelKey = 'getOwnedTokenAccountInfoModel';

  final _keyValueStorage = KeyValueStorageBase.instance;

  bool getIsMainnetEnabled() {
    return _keyValueStorage.getCommon<bool>(_isMainnetEnabled) ?? false;
  }

   void setMainnetEnabled(bool isMainnetEnabled) {
     _keyValueStorage.setCommon<bool>(_isMainnetEnabled, isMainnetEnabled);
   }

  bool getShowAgainDeleteNotificationDialog() {
    return _keyValueStorage.getCommon<bool>(_showAgainDeleteNotificationDialog) ?? true;
  }

  void setNotShowAgainDeleteNotificationDialog() {
    _keyValueStorage.setCommon<bool>(_showAgainDeleteNotificationDialog, false);
  }

  bool getHasEnterOnAddAppointmentScreen() {
    return _keyValueStorage.getCommon<bool>(_hasEnterAddAppointmentScreen) ?? false;
  }

  void setHasEnterOnAddAppointmentScreen() {
    _keyValueStorage.setCommon<bool>(_hasEnterAddAppointmentScreen, true);
  }

  bool getIsUserRegistered() {
    return _keyValueStorage.getCommon<bool>(_isUserRegistered) ?? false;
  }

  void setIsUserRegistered(bool isUserRegistered) {
    _keyValueStorage.setCommon<bool>(_isUserRegistered, isUserRegistered);
  }

  BCNetworksModel? getNetworkInfo() {
    final json = _keyValueStorage.getCommon<String>(_networkInfo);
    if (json == null) return null;
    return BCNetworksModel.fromJson(jsonDecode(json) as JSON);
  }

  User? getCurrentUser() {
    final json = _keyValueStorage.getCommon<String>(_userModel);
    if (json == null) return null;
    return User.fromJson(jsonDecode(json) as JSON);
  }

  OwnedTokenAccountInfoModel? getOwnedTokenAccountInfoModel() {
    final json = _keyValueStorage.getCommon<String>(_getOwnedTokenAccountInfoModelKey);
    if (json == null) return null;
    return OwnedTokenAccountInfoModel.fromJson(jsonDecode(json) as JSON);
  }

  String? getUserAddress() {
    final json = _keyValueStorage.getCommon<String>(_userAddress);
    if (json == null) return null;
    return json;
  }

  void setUserAddress(String userAddress) {
    _keyValueStorage.setCommon<String>(_userAddress, userAddress);
  }

  void setNetworksInfo(BCNetworksModel networkInfo) {
    String jsonToSave = jsonEncode(networkInfo.toJson());
    _keyValueStorage.setCommon<String>(_networkInfo, jsonToSave);
  }

  void setCurrentModel(User currentUser) {
    String jsonToSave = jsonEncode(currentUser.toJson());
    _keyValueStorage.setCommon<String>(_userModel, jsonToSave);
  }

  void setOwnedTokenAccountInfoModel(OwnedTokenAccountInfoModel ownedTokenAccountInfoModel) {
    String jsonToSave = jsonEncode(ownedTokenAccountInfoModel.toJson());
    _keyValueStorage.setCommon<String>(_getOwnedTokenAccountInfoModelKey, jsonToSave);
  }

  Future<String> getToken() async {
    final tokenResponse = await _keyValueStorage.getEncrypted(_token) ?? '';
    return tokenResponse;
  }

  void setToken({required String accessToken}) async {
    _keyValueStorage.setEncrypted(_token, accessToken);
  }


  /// Resets the authentication. Even though these methods are asynchronous, we
  /// don't care about their completion which is why we don't use `await` and
  /// let them execute in the background.
  Future<void> resetKeys() async {
    await _keyValueStorage.clearCommon();
    await _keyValueStorage.clearEncrypted();
  }
}
