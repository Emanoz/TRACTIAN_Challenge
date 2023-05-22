import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_app/data/models/asset_model.dart';
import 'package:tractian_app/data/models/user_model.dart';
import 'package:tractian_app/data/models/work_order_model.dart';
import 'package:tractian_app/ui/users/repository/user_repository.dart';
import 'package:tractian_app/ui/workOrders/work_order_detail_page.dart';
import 'package:tractian_app/ui/workOrders/work_order_form_page.dart';
import 'package:tractian_app/utils/adapter_controller.dart';
import 'package:tractian_app/utils/enums/assets_status.dart';
import 'package:tractian_app/utils/repository_interface.dart';
import '../../utils/enums/states.dart';
import '../../widgets/item_view.dart';
import '../assets/repository/asset_repository.dart';

class WorkOrdersPage extends StatefulWidget {
  final Repository<WorkOrder> repository;

  const WorkOrdersPage({Key? key, required this.repository}) : super(key: key);

  @override
  State<WorkOrdersPage> createState() => _WorkOrdersPageState();
}

class _WorkOrdersPageState extends State<WorkOrdersPage> {
  @override
  void initState() {
    widget.repository.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        if (widget.repository.controller.currentState == States.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: 32.0,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Search work order',
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFD9D9D9),
                        ),
                        labelStyle: GoogleFonts.roboto(
                            color: const Color(0xFFAFB8C1), fontWeight: FontWeight.w400, fontSize: 16.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Color(0xFFD0D7DE)),
                          borderRadius: BorderRadius.circular(35.0),
                        )),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Observer(builder: (context) {
                      return ListView.separated(
                        itemCount: widget.repository.controller.list.length,
                        itemBuilder: (_, index) => ItemView(
                          title: widget.repository.controller.list[index].title,
                          status: widget.repository.controller.list[index].checkStatus(),
                          subTitle: widget.repository.controller.list[index].description,
                          hasIcon: false,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => WorkOrderDetailPage(
                                order: widget.repository.controller.list[index],
                                workRepository: widget.repository,
                                userRepository: UserRepository(api: Dio(), controller: AdapterController<User>()),
                                assetRepository: AssetRepository(api: Dio(), controller: AdapterController<Asset>()),
                              ),
                            ),
                          ),
                        ),
                        separatorBuilder: (_, index) => Container(
                          color: const Color(0xFFD0D7DE),
                          height: 2.0,
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => WorkOrderFormPage(
                    assetRepository: AssetRepository(api: Dio(), controller: AdapterController<Asset>()),
                    userRepository: UserRepository(
                      api: Dio(),
                      controller: AdapterController<User>(),
                    ),
                  ),
                ),
              ),
          child: const Icon(Icons.add)),
    );
  }
}
