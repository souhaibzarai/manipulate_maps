part of 'phone_auth_cubit.dart';

@immutable
sealed class PhoneAuthState {}

final class PhoneAuthInitial extends PhoneAuthState {}

class Loading extends PhoneAuthState {}

class ErrorOccurred extends PhoneAuthState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}

class PhoneNumberSubmitted extends PhoneAuthState {}

class PhoneOTPVerified extends PhoneAuthState {}
