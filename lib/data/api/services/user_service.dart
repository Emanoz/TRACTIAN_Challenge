import '../../../main.dart';

enum UserService {
  users,
  usersById
  //Add more work order related endpoints as available
}

extension UserServiceExtension on UserService {
  String url() {
    switch(this) {
      case UserService.users:
        return '$baseUrl/users';
      case UserService.usersById:
        return '$baseUrl/users/';
    }
  }
}