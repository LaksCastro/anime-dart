import '../../../../core/domain/entities/entity.dart';

class ResourceTitle extends Entity {
  final String romaji;
  final String english;
  final String native;
  final String userPreferred;

  const ResourceTitle({
    this.romaji,
    this.english,
    this.native,
    this.userPreferred,
  }) : super('$english$native');

  @override
  List<Object> get props => [romaji, english, native, userPreferred];
}
