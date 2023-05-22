import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_app/data/models/checklist_model.dart';
import 'package:tractian_app/ui/assets/repository/asset_repository.dart';
import 'package:tractian_app/ui/users/repository/user_repository.dart';
import 'package:tractian_app/ui/workOrders/work_order_form_page.dart';
import 'package:tractian_app/utils/adapter_controller.dart';
import 'package:tractian_app/utils/enums/assets_status.dart';
import 'package:tractian_app/utils/repository_interface.dart';
import 'package:tractian_app/utils/state_controller.dart';

import '../../data/models/asset_model.dart';
import '../../data/models/user_model.dart';
import '../../data/models/work_order_model.dart';
import '../../utils/enums/states.dart';
import '../../widgets/custom_checkbox.dart';
import '../../widgets/custom_radio.dart';

class WorkOrderDetailPage extends StatefulWidget {
  final WorkOrder order;
  final Repository<WorkOrder> workRepository;
  final Repository<User> userRepository;
  final Repository<Asset> assetRepository;

  const WorkOrderDetailPage(
      {Key? key,
      required this.order,
      required this.workRepository,
      required this.userRepository,
      required this.assetRepository})
      : super(key: key);

  @override
  State<WorkOrderDetailPage> createState() => _WorkOrderDetailPageState();
}

class _WorkOrderDetailPageState extends State<WorkOrderDetailPage> {
  final checkBoxGroup = StateController(currentValue: 0);

  @override
  void initState() {
    super.initState();
    initRequests();
  }

  void initRequests() async {
    widget.workRepository.controller.currentState = States.loading;
    checkBoxGroup.setValueState(widget.order.statusId());
    for (int id in widget.order.assignedUserIds) {
      await widget.userRepository.getById(id);
    }
    await widget.assetRepository.getById(widget.order.assetId);
    widget.workRepository.controller.currentState = States.done;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        if (widget.workRepository.controller.currentState == States.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.asset('resources/icons/workOrderTitleIcon.svg'),
                    ),
                    Text(
                      widget.order.title,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                        color: const Color(0xFF24292F),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0, bottom: 16.0),
                  child: Text(
                    'Status (Click to refresh)',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: const Color(0xFF24292F),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRadio(
                      currentIndex: 0,
                      checkBoxGroup: checkBoxGroup,
                      icon: Icons.lock_open_outlined,
                      label: 'Open',
                      color: const Color(0xFF2188FF),
                      onTap: () async {
                        widget.order.status = 'open';
                        await widget.workRepository.update(widget.order);
                      },
                    ),
                    CustomRadio(
                      currentIndex: 1,
                      checkBoxGroup: checkBoxGroup,
                      icon: Icons.refresh_outlined,
                      label: 'In Progress',
                      color: const Color(0xFF2188FF),
                      onTap: () async {
                        widget.order.status = 'in progress';
                        await widget.workRepository.update(widget.order);
                      },
                    ),
                    CustomRadio(
                      currentIndex: 2,
                      checkBoxGroup: checkBoxGroup,
                      icon: Icons.check_circle_outline,
                      label: 'Done',
                      color: const Color(0xFF2188FF),
                      onTap: () async {
                        widget.order.status = 'completed';
                        await widget.workRepository.update(widget.order);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0, bottom: 28.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Assignee',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                                ),
                              ),
                            ),
                            Column(
                              children: List.generate(
                                widget.userRepository.controller.list.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          width: 24.0,
                                          height: 24.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24.0),
                                            color: Colors.green,
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              widget.userRepository.controller.list[index].name.substring(0, 1),
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        widget.userRepository.controller.list[index].name,
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            color: const Color(0xFF24292F)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Priority',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 14.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                color: Color(widget.order.checkPriority().color()),
                              ),
                              child: Text(
                                widget.order.checkPriority().text(),
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Asset',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.asset('resources/icons/assetItemIcon.svg'),
                    ),
                    Text(
                      widget.assetRepository.controller.list.first.name ?? '',
                      style: GoogleFonts.roboto(
                          fontSize: 16.0, fontWeight: FontWeight.w400, color: const Color(0xFF24292F)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Description',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                        ),
                      ),
                      Text(
                        widget.order.description,
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400, fontSize: 16.0, color: const Color(0xFF24292F)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Procedures checklist',
                    style:
                        GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                  ),
                ),
                Column(
                  children: List.generate(
                    widget.order.checklist.length,
                    (index) => CustomCheckbox(
                      label: Checklist.fromJson(widget.order.checklist[index]).task,
                      value: StateController(currentValue: Checklist.fromJson(widget.order.checklist[index]).completed),
                      onTap: (bool newValue) {
                        final checklist = Checklist.fromJson(widget.order.checklist[index]);
                        checklist.completed = !checklist.completed;
                        widget.order.checklist[index] = checklist.toJson();
                        widget.workRepository.update(widget.order);
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        }
      }),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2188FF),
        centerTitle: true,
        title: Text(
          '#${widget.order.id}',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => WorkOrderFormPage(
                    userRepository: UserRepository(api: Dio(), controller: AdapterController<User>()),
                    assetRepository: AssetRepository(api: Dio(), controller: AdapterController<Asset>()),
                  ),
                ),
              ),
          child: const Icon(Icons.edit)),
    );
  }
}
