abstract class SocialLoginStates
{}
class SocialLoginInitialState extends SocialLoginStates
{}
class SocialLoginLoadingState extends SocialLoginStates
{}
class SocialLoginSuccessState extends SocialLoginStates
{
final String uid;

  SocialLoginSuccessState(this.uid);
}
class SocialLoginErrorState extends SocialLoginStates
{

  late final String error;
  SocialLoginErrorState(this.error);
}
class SocialchangePasswordState extends SocialLoginStates
{}