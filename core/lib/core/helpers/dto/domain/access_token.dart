import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AccessToken extends Equatable {
  final String accessToken;
  final String tokenType;
  final DateTime expiresIn;
  final String refreshToken;
  final List<String> scopes;

  const AccessToken({
    @required this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.scopes,
  });

  AccessToken copyWith({
    String accessToken,
    String tokenType,
    DateTime expiresIn,
    String refreshToken,
    List<String> scopes,
  }) {
    return AccessToken(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
      refreshToken: refreshToken ?? this.refreshToken,
      scopes: scopes ?? this.scopes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'tokenType': tokenType,
      'expiresIn': expiresIn?.millisecondsSinceEpoch,
      'refreshToken': refreshToken,
      'scopes': scopes,
    };
  }

  factory AccessToken.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AccessToken(
      accessToken: map['accessToken'],
      tokenType: map['tokenType'],
      expiresIn: DateTime.fromMillisecondsSinceEpoch(map['expiresIn']),
      refreshToken: map['refreshToken'],
      scopes: List<String>.from(map['scopes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccessToken.fromJson(String source) =>
      AccessToken.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      accessToken,
      tokenType,
      expiresIn,
      refreshToken,
      scopes,
    ];
  }
}
