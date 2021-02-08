import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginCredentials extends Equatable {
  final String username;
  final String password;

  const LoginCredentials(
    String id, {
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];
}
