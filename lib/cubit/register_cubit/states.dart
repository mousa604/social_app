


abstract class RegisterStats{}
class RegisterInitialStats extends RegisterStats{}
class RegisterSuccessStats extends RegisterStats{}
class RegisterLoadinglStats extends RegisterStats{}
class RegisterShowePasswordlStats extends RegisterStats{}
class RegisterErrorlStats extends RegisterStats{
  final error;
  RegisterErrorlStats({this.error});
}

class CreateUserSuccessStats extends RegisterStats{}
class CreateUserErrorlStats extends RegisterStats{
  final error;
  CreateUserErrorlStats({this.error});
}