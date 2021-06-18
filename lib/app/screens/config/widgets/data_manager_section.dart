import 'package:anime_dart/app/screens/config/widgets/section_label.dart';
import 'package:anime_dart/app/screens/config/widgets/section_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataManagerSection extends StatefulWidget {
  DataManagerSection({Key key}) : super(key: key);

  @override
  _DataManagerSectionState createState() => _DataManagerSectionState();
}

class _DataManagerSectionState extends State<DataManagerSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel('Gerenciamento de dados'),
        SectionTile(
          leading: Icon(Icons.bookmark),
          title: Text('Exportar histórico de assistidos'),
          onTap: _exportWatchedData,
        ),
        SectionTile(
          leading: Icon(Icons.favorite),
          title: Text('Exportar favoritos'),
        ),
        SectionTile(
          leading: Icon(Icons.backup),
          title: Text('Exportar tudo'),
        ),
        SectionTile(
          leading: Icon(Icons.cloud_download),
          title: Text('Importar dados'),
        ),
      ],
    );
  }

  void _exportWatchedData() async {
    // final result = await FilePicker.platform.pickFiles(
    //   type: FileType.image,
    // );

    // print(result);
  }
}
