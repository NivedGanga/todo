class UserModel {
  UserModel._internal();
  static UserModel instance = UserModel._internal();
  factory UserModel() {
    return instance;
  }
  late final uid;
}
