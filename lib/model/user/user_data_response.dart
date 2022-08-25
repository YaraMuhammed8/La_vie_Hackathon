class UserDataResponse {
  UserDataResponse({
    required this.type,
    required this.message,
    required this.data,
  });
  late final String type;
  late final String message;
  late final User data;

  UserDataResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = User.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class User {
  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    required this.address,
    required this.role,
    this.userPoints = 0,
    required this.userNotification,
  });
  late final String userId;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String imageUrl;
  late final String address;
  late final String role;
  late final int userPoints;
  late final List<dynamic> userNotification;

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    address = json['address'] ?? "";
    role = json['role'];
    userPoints = json['UserPoints'] ?? 0;
    userNotification =
        List.castFrom<dynamic, dynamic>(json['UserNotification']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['imageUrl'] = imageUrl;
    _data['address'] = address;
    _data['role'] = role;
    _data['UserPoints'] = userPoints;
    _data['UserNotification'] = userNotification;
    return _data;
  }
}
