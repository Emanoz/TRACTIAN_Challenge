import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_app/data/models/checklist_model.dart';
import 'package:tractian_app/data/models/work_order_model.dart';
import 'package:tractian_app/ui/workOrders/repository/work_order_repository.dart';
import 'package:tractian_app/utils/enums/assets_status.dart';
import 'package:tractian_app/utils/enums/states.dart';
import 'package:tractian_app/utils/state_controller.dart';
import 'package:tractian_app/widgets/custom_checkbox.dart';
import 'package:tractian_app/widgets/custom_radio.dart';
import 'package:tractian_app/widgets/item_view.dart';
import '../../data/models/asset_model.dart';
import '../../data/models/user_model.dart';
import '../../utils/repository_interface.dart';
import '../../widgets/custom_options_button.dart';

class WorkOrderFormPage extends StatefulWidget {
  final WorkOrder? editOrder;
  final Repository<Asset> assetRepository;
  final Repository<User> userRepository;
  final Repository<WorkOrder> orderRepository;

  const WorkOrderFormPage(
      {Key? key,
      this.editOrder,
      required this.assetRepository,
      required this.userRepository,
      required this.orderRepository})
      : super(key: key);

  @override
  State<WorkOrderFormPage> createState() => _WorkOrderFormPageState();
}

class _WorkOrderFormPageState extends State<WorkOrderFormPage> {
  final priorityGroup = StateController(currentValue: 0);
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerAsset = StateController<Asset?>(currentValue: null);
  final controllerUser = StateController<List<User>?>(currentValue: null);
  final controllerChecklist = StateController<List<Checklist>>(currentValue: [Checklist(false, '')]);
  final List<TextEditingController> controllerChecklistTasks = [TextEditingController()];
  final enableButton = StateController(currentValue: false);

  @override
  void initState() {
    initRequests();
    super.initState();
  }

  void initRequests() async {
    widget.orderRepository.controller.currentState = States.loading;
    if (widget.editOrder != null) {
      controllerTitle.text = widget.editOrder!.title;
      controllerDescription.text = widget.editOrder!.description;

      await widget.assetRepository.getById(widget.editOrder!.assetId);
      controllerAsset.setValueState(widget.assetRepository.controller.list.first);

      for (var id in widget.editOrder!.assignedUserIds) {
        await widget.userRepository.getById(id);
      }

      controllerUser.setValueState(widget.userRepository.controller.list);

      switch (widget.editOrder!.checkPriority()) {
        case AssetsStatus.low:
          priorityGroup.setValueState(0);
          break;
        case AssetsStatus.medium:
          priorityGroup.setValueState(1);
          break;
        case AssetsStatus.high:
          priorityGroup.setValueState(2);
          break;
      }

      var checklists;
      try {
        checklists = List.of(widget.editOrder!.checklist).map((e) => Checklist.fromJson(e)).toList();
      } catch(ex) {
        checklists = widget.editOrder!.checklist;
      }

      controllerChecklist.setValueState(checklists);
    }

    widget.orderRepository.controller.currentState = States.done;

    await widget.assetRepository.getAll();
    await widget.userRepository.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
          child: Observer(builder: (context) {
            if (widget.orderRepository.controller.currentState == States.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (value) => enableButton.setValueState(validateFields()),
                    controller: controllerTitle,
                    decoration: InputDecoration(
                      labelText: 'What needs to be done?',
                      labelStyle: GoogleFonts.roboto(
                          color: const Color(0xFFAFB8C1), fontWeight: FontWeight.w400, fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 26.0),
                    child: Text(
                      'Description',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                    ),
                  ),
                  TextField(
                    controller: controllerDescription,
                    decoration: InputDecoration(
                      labelText: 'Add a description',
                      labelStyle: GoogleFonts.roboto(
                          color: const Color(0xFFAFB8C1), fontWeight: FontWeight.w400, fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0, bottom: 8.0),
                    child: Text(
                      'Asset',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                    ),
                  ),
                  CustomOptionsButton(
                    label:
                        controllerAsset.currentValue == null ? 'Select an Asset' : controllerAsset.currentValue!.name!,
                    onTap: () {
                      return showItemsOptions(
                        context,
                        itemCount: widget.assetRepository.controller.list.length,
                        label: 'Assets',
                        itemBuilder: (_, index) => ItemView(
                          onTap: () {
                            controllerAsset.setValueState(widget.assetRepository.controller.list[index]);
                            enableButton.setValueState(validateFields());
                            Navigator.of(context).pop();
                          },
                          title: widget.assetRepository.controller.list[index].name!,
                          status: widget.assetRepository.controller.list[index].checkStatus(),
                          subTitle: widget.assetRepository.controller.list[index].model!,
                          hasIcon: false,
                          image: widget.assetRepository.controller.list[index].image,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 26.0),
                    child: Text(
                      'Assignees',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                    ),
                  ),
                  CustomOptionsButton(
                      label: controllerUser.currentValue == null
                          ? 'Select an User'
                          : List.generate(controllerUser.currentValue!.length,
                                  (index) => '${controllerUser.currentValue![index].name} | ')
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', '')
                              .replaceAll(',', ''),
                      onTap: () async {
                        return showItemsOptions(
                          context,
                          itemCount: widget.userRepository.controller.list.length,
                          label: 'Users',
                          itemBuilder: (_, index) => ItemView(
                            onTap: () {
                              if (widget.editOrder != null) {
                                final users = controllerUser.currentValue!;
                                users.add(widget.userRepository.controller.list[index]);
                                controllerUser.setValueState(users);
                              } else {
                                controllerUser.setValueState([widget.userRepository.controller.list[index]]);
                              }

                              enableButton.setValueState(validateFields());
                              Navigator.of(context).pop();
                            },
                            title: widget.userRepository.controller.list[index].name,
                            subTitle: widget.userRepository.controller.list[index].email,
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0, bottom: 20.0),
                    child: Text(
                      'Priority',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRadio(
                        checkBoxGroup: priorityGroup,
                        currentIndex: 0,
                        label: 'Low',
                        color: const Color(0xFF2DA44E),
                      ),
                      CustomRadio(
                        checkBoxGroup: priorityGroup,
                        currentIndex: 1,
                        label: 'Medium',
                        color: const Color(0xFFE16F24),
                      ),
                      CustomRadio(
                        checkBoxGroup: priorityGroup,
                        currentIndex: 2,
                        label: 'High',
                        color: const Color(0xFFFA4549),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0, bottom: 8.0),
                    child: Text(
                      'Procedures checklist',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      controllerChecklist.currentValue.length,
                      (index) {
                        return CustomCheckbox(
                        controller: widget.editOrder == null ? controllerChecklistTasks[index] : null,
                        label: controllerChecklist.currentValue[index].task,
                        value: StateController(currentValue: controllerChecklist.currentValue[index].completed),
                        onTap: (bool newValue) {
                          controllerChecklist.currentValue[index].completed = newValue;
                        },
                      );},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 21.0, bottom: 34.0),
                    child: widget.editOrder == null ? InkWell(
                      onTap: () {
                        TextEditingController controller = TextEditingController();
                        controllerChecklistTasks.add(controller);

                        final list = List.of(controllerChecklist.currentValue);
                        list.add(Checklist(true, ''));

                        //controllerChecklist.currentValue[list.length - 1].task = controllerChecklistTasks[list.length - 1].text;
                        controllerChecklist.setValueState(list);
                      },
                      child: Container(
                        width: 96.0,
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFF2188FF))),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              color: Color(0xFF2188FF),
                            ),
                            Text(
                              'Add item',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500, fontSize: 12.0, color: const Color(0xFF2188FF)),
                            )
                          ],
                        ),
                      ),
                    ) : Container(),
                  ),
                  Material(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                    color: !enableButton.currentValue ? Colors.black12 : const Color(0xFF2188FF),
                    child: InkWell(
                      onTap: !enableButton.currentValue ? null : () {
                        createOrEdit();
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0)),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SvgPicture.asset('resources/icons/saveIcon.svg'),
                            ),
                            Text(
                              'SAVE',
                              style:
                                  GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16.0, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          }),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2188FF),
        centerTitle: true,
        title: Text(
          //'#${order.id}',
          'New Work Order',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void createOrEdit() async {
    AssetsStatus priority = AssetsStatus.done;
    switch (priorityGroup.currentValue) {
      case 0:
        priority = AssetsStatus.low;
        break;
      case 1:
        priority = AssetsStatus.medium;
        break;
      case 2:
        priority = AssetsStatus.high;
        break;
    }

    int? id = widget.editOrder?.id;
    if (widget.editOrder == null) {
      id = await (widget.orderRepository as WorkOrderRepository).generateId();
    }

    List<int> listUserIds = [];
    for (User user in controllerUser.currentValue!) {
      listUserIds.add(user.id!);
    }

    /*if(controllerChecklist.currentValue.length == 1) {
      controllerChecklist.currentValue.first.task = controllerChecklistTasks.first.text;
    }*/

    if(widget.editOrder == null) {
      for(var i = 0; i < controllerChecklist.currentValue.length; i++) {
        controllerChecklist.currentValue[i].task = controllerChecklistTasks[i].text;
      }
    }

    final order = WorkOrder(
      id!,
      controllerTitle.text,
      controllerDescription.text,
      priority.text().toLowerCase(),
      controllerAsset.currentValue!.id!,
      listUserIds,
      controllerChecklist.currentValue,
      AssetsStatus.open.text().toLowerCase(),
    );

    if (widget.editOrder == null) {
      widget.orderRepository.insert(order);
      Navigator.of(context).pop(null);
    } else {
      Navigator.of(context).pop(order);
    }
  }

  void showItemsOptions(
    BuildContext context, {
    required String label,
    required int itemCount,
    required Function(BuildContext context, int index) itemBuilder,
  }) =>
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) => Container(
          decoration:
              const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(32.0))),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42.0,
                height: 5.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFD0D7DE),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                child: Text(
                  label,
                  style:
                      GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: itemCount,
                  separatorBuilder: (_, index) => const Divider(),
                  itemBuilder: (context, index) => itemBuilder(context, index),
                ),
              ),
            ],
          ),
        ),
      );

  bool validateFields() => controllerUser.currentValue != null && controllerAsset.currentValue != null && controllerTitle.text.isNotEmpty;
}
