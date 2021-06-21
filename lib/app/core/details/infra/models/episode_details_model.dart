import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:anime_dart/app/core/details/domain/entities/episode_details.dart';

class EpisodeDetailsModel extends EpisodeDetails {
  final String id;
  final String animeId;
  final String label;
  final String url;
  final String urlHd;
  final String urlFullHd;
  final String imageUrl;
  final Map<String, String> imageHttpHeaders;
  final double stats;

  EpisodeDetailsModel({
    this.id,
    this.animeId,
    this.label,
    this.url,
    this.urlHd,
    this.urlFullHd,
    this.imageUrl,
    this.imageHttpHeaders,
    this.stats,
  });

  EpisodeDetailsModel copyWith({
    String id,
    String animeId,
    String label,
    String url,
    String urlHd,
    String urlFullHd,
    String imageUrl,
    Map<String, String> imageHttpHeaders,
    double stats,
  }) {
    return EpisodeDetailsModel(
      id: id ?? this.id,
      animeId: animeId ?? this.animeId,
      label: label ?? this.label,
      url: url ?? this.url,
      urlHd: urlHd ?? this.urlHd,
      urlFullHd: urlFullHd ?? this.urlFullHd,
      imageUrl: imageUrl ?? this.imageUrl,
      imageHttpHeaders: imageHttpHeaders ?? this.imageHttpHeaders,
      stats: stats ?? this.stats,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'animeId': animeId,
      'label': label,
      'url': url,
      'urlHd': urlHd,
      'urlFullHd': urlFullHd,
      'imageUrl': imageUrl,
      'imageHttpHeaders': imageHttpHeaders,
      'stats': stats,
    };
  }

  factory EpisodeDetailsModel.fromMap(Map<String, dynamic> map) {
    return EpisodeDetailsModel(
      id: map['id'],
      animeId: map['animeId'],
      label: map['label'],
      url: map['url'],
      urlHd: map['urlHd'],
      urlFullHd: map['urlFullHd'],
      imageUrl: map['imageUrl'],
      imageHttpHeaders: Map<String, String>.from(map['imageHttpHeaders']),
      stats: map['stats'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpisodeDetailsModel.fromJson(String source) =>
      EpisodeDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpisodeDetailsModel(id: $id, animeId: $animeId, label: $label, url: $url, urlHd: $urlHd, urlFullHd: $urlFullHd, imageUrl: $imageUrl, imageHttpHeaders: $imageHttpHeaders, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EpisodeDetailsModel &&
        other.id == id &&
        other.animeId == animeId &&
        other.label == label &&
        other.url == url &&
        other.urlHd == urlHd &&
        other.urlFullHd == urlFullHd &&
        other.imageUrl == imageUrl &&
        mapEquals(other.imageHttpHeaders, imageHttpHeaders) &&
        other.stats == stats;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        animeId.hashCode ^
        label.hashCode ^
        url.hashCode ^
        urlHd.hashCode ^
        urlFullHd.hashCode ^
        imageUrl.hashCode ^
        imageHttpHeaders.hashCode ^
        stats.hashCode;
  }
}
