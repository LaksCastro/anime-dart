// import 'dart:typed_data';

// import 'package:anime_dart/server/helpers/dto/feature.dart';
// import 'package:dartz/dartz.dart';

// import '../../../../helpers/dto/call_context.dart';
// import '../../../../helpers/dto/page_context.dart';
// import '../../../../helpers/errors/app_exception.dart';
// import '../entities/resource/resource_category.dart';
// import '../entities/resource/resource_details.dart';

// abstract class SearchRepository<
//     T extends ResourceDetails,
//     C extends ResourceCategory,
//     P extends PageContext<T>,
//     I extends CallContext> {
//   const SearchRepository();

//   Feature<Args<C, I>, Future<Either<AppException, P>>> get searchByCategory;
//   Feature<Args<List<C>, I>, Future<Either<AppException, P>>>
//       get searchByCategories;
//   Feature<Args<String, I>, Future<Either<AppException, P>>> get searchByText;
//   Feature<Args<String, I>, Future<Either<AppException, P>>>
//       get searchByImageBase64;
//   Feature<Args<Uint64List, I>, Future<Either<AppException, P>>>
//       get searchByImageBytes;

//   Feature<Args<void, I>, Future<Either<AppException, P>>> get randomList;
//   Feature<Args<void, I>, Future<Either<AppException, P>>> get randomSingle;

//   Feature<void, Future<Either<AppException, P>>> get topAllTime;
//   Feature<void, Future<Either<AppException, P>>> get topAiring;
//   Feature<void, Future<Either<AppException, P>>> get manyRandom;
//   Feature<void, Future<Either<AppException, PageContext<List<C>>>>>
//       get availableCategories;
//   Feature<void, Future<Either<AppException, RepositoryData>>>
//       get repositoryData;
// }
