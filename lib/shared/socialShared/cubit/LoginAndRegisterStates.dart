part of 'LoginAndRegisterCubit.dart';

sealed class LoginAndRegisterStates {}

final class SocialCubitInitial extends LoginAndRegisterStates {}

final class SocialLoginLoadingState extends LoginAndRegisterStates {}

final class SocialLoginSuccessState extends LoginAndRegisterStates {
  final String? uId;
  SocialLoginSuccessState(this.uId);
}

final class SocialLoginFailureState extends LoginAndRegisterStates {
  final String error;

  SocialLoginFailureState(this.error);
}




final class SocialSignUpCubitInitial extends LoginAndRegisterStates {}

final class SocialSignUpLoadingState extends LoginAndRegisterStates {}

final class SocialSignUpSuccessState extends LoginAndRegisterStates {

}

final class SocialSignUpFailureState extends LoginAndRegisterStates {
  final String error;

  SocialSignUpFailureState(this.error);
}




class SocialChangePasswordVisibility extends LoginAndRegisterStates {}

class SignInState extends LoginAndRegisterStates {}

class SignUpState extends LoginAndRegisterStates {}

class SignOutState extends LoginAndRegisterStates {}

class AppChangeModeState extends LoginAndRegisterStates {}

class CreateUserErrorState extends LoginAndRegisterStates {
  final String errMessage;

  CreateUserErrorState(this.errMessage);
}

class CreateUserSuccessState extends LoginAndRegisterStates {}
class SocialChangeBottomNavigationBarState extends LoginAndRegisterStates {}
