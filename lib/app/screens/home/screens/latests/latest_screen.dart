import 'package:anime_dart/app/screens/home/screens/latests/widgets/list.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:anime_dart/app/store/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LatestsScreen extends StatefulWidget {
  LatestsScreen({Key key}) : super(key: key);

  @override
  _LatestsScreenState createState() => _LatestsScreenState();
}

class _LatestsScreenState extends State<LatestsScreen> {
  final homeStore = getIt<HomeStore>();
  final centralStore = getIt<CentralStore>();

  @override
  void initState() {
    super.initState();

    homeStore.loadLatests();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(
        builder: (_) {
          if (homeStore.loadingLatests) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (homeStore.latestsError != null) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      homeStore.latestsError,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                  ),
                  FlatButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: homeStore.loadLatests,
                    child: Text('Tentar novamente'),
                  )
                ],
              ),
            );
          }

          return LatestEpisodes();
        },
      ),
    );
  }
}
