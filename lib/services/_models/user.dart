class User {
  String? firstName;
  String? lastName;
  String? accessToken;
  User.empty();
  User(this.firstName, this.lastName, this.accessToken);
  Map toJson() => {
    'firstName':  firstName,
    'lastName': lastName,
    'accessToken': accessToken
  };
}