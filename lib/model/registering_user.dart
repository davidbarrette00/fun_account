class RegisteringUser {
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String phoneNumber;

  RegisteringUser(
      String? firstName, String? lastName, this.email, this.password, this.phoneNumber) {
    this.firstName = (firstName == null) ? "" : firstName;
    this.lastName = (lastName == null) ? "" : lastName;
  }
}