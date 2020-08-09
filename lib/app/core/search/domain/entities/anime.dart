import "dart:convert";

import 'package:flutter/foundation.dart';

class Anime {
  final String id;
  final String title;
  final String imageUrl;
  final Map<String, String> imageHttpHeaders;
  final bool isFavorite;

  Anime({
    this.id,
    this.title,
    this.imageUrl,
    this.imageHttpHeaders,
    this.isFavorite,
  });

  Anime copyWith({
    String id,
    String title,
    String imageUrl,
    Map<String, String> imageHttpHeaders,
    bool isFavorite,
  }) {
    return Anime(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      imageHttpHeaders: imageHttpHeaders ?? this.imageHttpHeaders,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'imageHttpHeaders': imageHttpHeaders,
      'isFavorite': isFavorite,
    };
  }

  factory Anime.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Anime(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      imageHttpHeaders: Map<String, String>.from(map['imageHttpHeaders']),
      isFavorite: map['isFavorite'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Anime.fromJson(String source) => Anime.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Anime(id: $id, title: $title, imageUrl: $imageUrl, imageHttpHeaders: $imageHttpHeaders, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Anime &&
        o.id == id &&
        o.title == title &&
        o.imageUrl == imageUrl &&
        mapEquals(o.imageHttpHeaders, imageHttpHeaders) &&
        o.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imageUrl.hashCode ^
        imageHttpHeaders.hashCode ^
        isFavorite.hashCode;
  }
}
