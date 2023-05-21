import 'package:flutter/material.dart';
import 'package:tractian_app/ui/assets/asset_detail_page.dart';
import 'package:tractian_app/utils/enums/assets_status.dart';
import 'package:tractian_app/widgets/item_view.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.separated(
        itemBuilder: (_, index) => ItemView(
          title: 'M14 Mill Shaft Motor',
          status: AssetsStatus.inProgress,
          image: 'resources/icons/exampleImage.svg',
          subTitle: 'Injection/Paiting',
          hasIcon: true,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AssetDetailPage())),
        ),
        separatorBuilder: (_, index) => const Divider(),
        itemCount: 10,
      ),
    );
  }
}
