abstract class LoginStats{}
class LoginInitialStats extends LoginStats{}
class LoginSuccessStats extends LoginStats{
  final String uid;
  LoginSuccessStats(this.uid);
}
class LoginLoadinglStats extends LoginStats{}
class LoginShowePasswordlStats extends LoginStats{}
class LoginErrorlStats extends LoginStats{
  final error;
  LoginErrorlStats({this.error});
}