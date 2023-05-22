import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tractian_app/data/models/asset_model.dart';
import 'package:tractian_app/ui/assets/asset_detail_page.dart';
import 'package:tractian_app/ui/assets/repository/asset_repository.dart';
import 'package:tractian_app/utils/adapter_controller.dart';
import 'package:tractian_app/utils/enums/assets_status.dart';
import 'package:tractian_app/utils/repository_interface.dart';
import 'package:tractian_app/widgets/item_view.dart';

import '../../utils/enums/states.dart';

class AssetsPage extends StatefulWidget {
  final Repository<Asset> repository;

  const AssetsPage({Key? key, required this.repository}) : super(key: key);

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  @override
  void initState() {
    widget.repository.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (widget.repository.controller.currentState == States.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListView.separated(
            itemBuilder: (_, index) => ItemView(
              title: widget.repository.controller.list[index].name ?? '',
              status: widget.repository.controller.list[index].checkStatus(),
              image: widget.repository.controller.list[index].image,
              subTitle: widget.repository.controller.list[index].model ?? '',
              hasIcon: true,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AssetDetailPage(
                    asset: widget.repository.controller.list[index],
                    repository: AssetRepository(api: Dio(), controller: AdapterController<Asset>()),
                  ),
                ),
              ),
            ),
            separatorBuilder: (_, index) => const Divider(),
            itemCount: widget.repository.controller.list.length,
          ),
        );
      }
    });
  }
}
