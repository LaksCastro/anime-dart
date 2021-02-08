import 'package:dartz/dartz.dart';

import '../../../../../../helpers/errors/app_exception.dart';
import '../../../../../browse/domain/entities/anime/anime_details.dart';
import '../../../../../browse/domain/errors/browse_errors.dart';
import '../../../../../browse/domain/usecases/search_by_text.dart';

class MyAnimeListSearchMangasByText
    extends SearchByText<String, List<AnimeDetails>> {
  const MyAnimeListSearchMangasByText();

  @override
  Future<Either<AppException, List<AnimeDetails>>> call(String input) async {
    return Left(UnsupportedUseCaseException());
  }
}
