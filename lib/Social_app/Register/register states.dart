abstract class SocialRegisterStates{}
class InitialRegisterState extends SocialRegisterStates{}
class ChangePassRegisterState extends SocialRegisterStates{}
class LoadingRegisterState extends SocialRegisterStates{}
class SuccessRegisterState extends SocialRegisterStates{}
class ErrorRegisterState extends SocialRegisterStates{
  late final String error;
  ErrorRegisterState(this.error);
}
class SuccessCreateUserState extends SocialRegisterStates{}
class ErrorCreateUserState extends SocialRegisterStates{
  late final String error;
  ErrorCreateUserState(this.error);
}