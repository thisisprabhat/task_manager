import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '/core/constants/app_assets.dart';
import '/core/utils/colored_log.dart';

part 'base_exception.dart';
part 'exception_handler.dart';

class AuthenticationException extends AppException {
  AuthenticationException({
    super.title = 'Authentication Failed',
    super.message = 'Authentication Failed, try again',
    super.exceptionType = 'Auth Exception',
  });
}

class InternetSocketException extends AppException {
  final String? errorMessage;
  InternetSocketException(this.errorMessage)
      : super(
          title: 'Network Problem',
          message: errorMessage ??
              'There is some issue with your wifi or your mobile internet',
          exceptionType: 'Internet Error',
        );
}

class ApiHttpExceptionException extends AppException {
  final String? errorMessage;
  ApiHttpExceptionException(this.errorMessage)
      : super(
          title: 'Network Problem',
          message: errorMessage,
          exceptionType: 'Api Error',
        );
}

class DataFormatException extends AppException {
  final String? errorMessage;
  DataFormatException(this.errorMessage)
      : super(
          title: 'Format Exception',
          message: errorMessage,
          exceptionType: 'Format Exception',
        );
}

class ApiTimeOutException extends AppException {
  final String? errorMessage;
  ApiTimeOutException(this.errorMessage)
      : super(
          title: 'TimeOut Exception',
          message: errorMessage,
          exceptionType: 'TimeOut Error',
        );
}

class BadRequestException extends AppException {
  BadRequestException()
      : super(
          title: 'Bad Request',
          message: 'Your request is invalid.',
          exceptionType: 'BadRequestException',
        );
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(
          title: 'Unauthorized',
          message: 'Your API key is wrong.',
          exceptionType: 'UnAuthorizedException',
        );
}

class NotFoundException extends AppException {
  NotFoundException([String? message, String? url])
      : super(
          title: 'Not Found',
          message: 'No Results Found!',
          lottiePath: AppAssets.notFoundAnimation,
          exceptionType: 'Not Found',
        );
}

class FirestoreException extends AppException {
  FirestoreException({
    super.title = 'Firestore error',
    super.message = 'There is something wrong with your request',
  }) : super(
          exceptionType: 'FirestoreException',
        );
}
