
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_wallet/api/utils/problem_details_model.dart';

import '../../routes/app_router.dart';
import '../../routes/routes.dart';
import 'exception_constants.dart';

//Helpers


part 'network_exception.freezed.dart';

@freezed
class NetworkException with _$NetworkException {
  const factory NetworkException.FormatException({
    required String name,
    required String message,
  }) = _FormatException;

  const factory NetworkException.FetchDataException({
    required String name,
    required String message,
  }) = _FetchDataException;

  const factory NetworkException.ApiException({
    required String name,
    required String message,
  }) = _ApiException;

  const factory NetworkException.TokenExpiredException({
    required String name,
    required String message,
  }) = _TokenExpiredException;

  const factory NetworkException.UnrecognizedException({
    required String name,
    required String message,
  }) = _UnrecognizedException;

  const factory NetworkException.CancelException({
    required String name,
    required String message,
  }) = _CancelException;

  const factory NetworkException.ConnectTimeoutException({
    required String name,
    required String message,
  }) = _ConnectTimeoutException;

  const factory NetworkException.ReceiveTimeoutException({
    required String name,
    required String message,
  }) = _ReceiveTimeoutException;

  const factory NetworkException.SendTimeoutException({
    required String name,
    required String message,
  }) = _SendTimeoutException;

  const factory NetworkException.ResponseError(
      {required String name,
      required String message,
      ProblemDetails? details}) = _ResponseError;

  static NetworkException getDioException(Exception error) {
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            return const NetworkException.CancelException(
              name: ExceptionConstants.CancelException,
              message: 'Request cancelled prematurely',
            );
          case DioExceptionType.connectionTimeout:
            return const NetworkException.ConnectTimeoutException(
              name: ExceptionConstants.ConnectTimeoutException,
              message: 'Connection not established',
            );
          case DioExceptionType.sendTimeout:
            return const NetworkException.SendTimeoutException(
              name: ExceptionConstants.SendTimeoutException,
              message: 'Failed to send',
            );
          case DioExceptionType.receiveTimeout:
            return const NetworkException.ReceiveTimeoutException(
              name: ExceptionConstants.ReceiveTimeoutException,
              message: 'Failed to receive',
            );
          case DioExceptionType.badResponse:
            if (error.response != null) {
              if (error.response!.data.isEmpty) {
                return NetworkException.ResponseError(
                    name: ExceptionConstants.FetchResponseException,
                    message: error.response!.statusMessage != null ? error.response!.statusMessage! : "",
                    details: null);
              }
              if (error.response!.statusCode == 401) {
                Navigator.of(AppRouter.navigatorKey.currentContext!).pushNamedAndRemoveUntil(Routes.LoginScreenRoute, (route) => false);
                 return const NetworkException.ResponseError(
                     name: ExceptionConstants.FetchResponseException,
                     message: "",
                     details: null);
              } else {
                var errorDetails = ProblemDetails.fromJson(error.response!.data);
                return NetworkException.ResponseError(
                    name: ExceptionConstants.FetchResponseException,
                    message: errorDetails.title,
                    details: errorDetails);
              }
            } else {
              return const NetworkException.FetchDataException(
                name: ExceptionConstants.FetchDataException,
                message: 'Unable to fetch data',
              );
            }
          case DioExceptionType.unknown:
            if (error.message != null && error.message!.contains(ExceptionConstants.SocketException)) {
              return const NetworkException.FetchDataException(
                name: ExceptionConstants.FetchDataException,
                message: 'No internet connectivity',
              );
            }
            final name = error.type.name;
            final message = error.message;
            switch (name) {
              case ExceptionConstants.TokenExpiredException:
                return NetworkException.TokenExpiredException(
                  name: name,
                  message: message ?? "TokenExpiredException",
                );
              default:
                return NetworkException.ApiException(
                  name: name,
                  message: message ?? "ApiException",
                );
            }
          case DioExceptionType.badCertificate: return const NetworkException.UnrecognizedException(
            name: ExceptionConstants.UnrecognizedException,
            message: 'badCertificate',
          );
          case DioExceptionType.connectionError: return const NetworkException.UnrecognizedException(
            name: ExceptionConstants.UnrecognizedException,
            message: 'connectionError',
          );
        }
      } else {
        return const NetworkException.UnrecognizedException(
          name: ExceptionConstants.UnrecognizedException,
          message: 'Error unrecognized',
        );
      }
    } on FormatException catch (e) {
      return NetworkException.FormatException(
        name: ExceptionConstants.FormatException,
        message: e.message,
      );
    } on Exception catch (_) {
      return const NetworkException.UnrecognizedException(
        name: ExceptionConstants.UnrecognizedException,
        message: 'Error unrecognized',
      );
    }
  }
}
