import '../../../../../helpers/dto/enums/short_locale.dart';
import '../../../../auth/domain/usecases/request_oauth_code.dart';
import '../../../../auth/domain/usecases/request_oauth_token.dart';
import '../../../../browse/domain/enums/media_type.dart';
import '../../../../browse/domain/enums/plugin_type.dart';
import '../../../../browse/domain/usecases/search_by_text.dart';
import '../../../../core/domain/entities/usecase.dart';
import '../../../domain/entities/plugin/plugin.dart';
import '../../../domain/entities/plugin/plugin_auth_controller.dart';
import '../../../domain/entities/plugin/plugin_controller.dart';
import '../../../domain/entities/plugin/plugin_info.dart';
import 'usecases/anilist_request_oauth_code.dart';
import 'usecases/anilist_request_oauth_token.dart';
import 'usecases/search_animes_by_text.dart';

part 'anilist_auth_controller.dart';
part 'anilist_controller.dart';
part 'anilist_info.dart';

class AniListPlugin extends Plugin {
  static const _controller = AniListController();
  static const _authController = AniListAuthController();
  static const _info = AniListInfo();

  const AniListPlugin()
      : super(
          'app.plugin.anilist',
          controller: _controller,
          info: _info,
          authController: _authController,
        );

  @override
  List<Object> get props => [info];
}
