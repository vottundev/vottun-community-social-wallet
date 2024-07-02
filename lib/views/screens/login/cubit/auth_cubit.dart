import 'package:bloc/bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:social_wallet/di/injector.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  void getUserAccessTokenValidity() async {
    try {
      String accessToken = await getKeyValueStorage().getToken();
      if (accessToken.isNotEmpty) {
        DateTime accessTokenExpirationDate =
        JwtDecoder.getExpirationDate(accessToken);
        DateTime now = DateTime.now();
        bool hasAccessTokenExpired = now.isAfter(accessTokenExpirationDate);
        emit(state.copyWith(
            hasAccessTokenExpired: hasAccessTokenExpired,
            status: hasAccessTokenExpired
                ? AuthStatus.notLogged
                : AuthStatus.logged));
      } else {
        emit(state.copyWith(
            hasAccessTokenExpired: true, status: AuthStatus.notLogged));
      }
    } catch (exception) {
      emit(state.copyWith(
          hasAccessTokenExpired: true, status: AuthStatus.notLogged));
    }

  }
}
