import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_app/data/models/work_order_model.dart';
import 'package:tractian_app/utils/enums/assets_status.dart';
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

  const WorkOrderFormPage({
    Key? key,
    this.editOrder,
    required this.assetRepository,
    required this.userRepository,
  }) : super(key: key);

  @override
  State<WorkOrderFormPage> createState() => _WorkOrderFormPageState();
}

class _WorkOrderFormPageState extends State<WorkOrderFormPage> {
  final priorityGroup = StateController(currentValue: 0);
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerAsset = StateController<Asset?>(currentValue: null);
  final controllerUser = StateController<User?>(currentValue: null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
          child: Observer(
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controllerTitle,
                    decoration: InputDecoration(
                      labelText: 'What needs to be done?',
                      labelStyle:
                          GoogleFonts.roboto(color: const Color(0xFFAFB8C1), fontWeight: FontWeight.w400, fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 26.0),
                    child: Text(
                      'Description',
                      style:
                          GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                    ),
                  ),
                  TextField(
                    controller: controllerDescription,
                    decoration: InputDecoration(
                      labelText: 'Add a description',
                      labelStyle:
                          GoogleFonts.roboto(color: const Color(0xFFAFB8C1), fontWeight: FontWeight.w400, fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0, bottom: 8.0),
                    child: Text(
                      'Asset',
                      style:
                          GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                    ),
                  ),
                  CustomOptionsButton(
                    label: controllerAsset.currentValue == null ? 'Select an Asset' : controllerAsset.currentValue!.name!,
                    onTap: () async {
                      await widget.assetRepository.getAll();

                      return showItemsOptions(
                        context,
                        itemCount: widget.assetRepository.controller.list.length,
                        label: 'Assets',
                        itemBuilder: (_, index) => ItemView(
                          onTap: () {
                            controllerAsset.setValueState(widget.assetRepository.controller.list[index]);
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
                      style:
                          GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                    ),
                  ),
                  CustomOptionsButton(
                      label: controllerUser.currentValue == null ? 'Select an User' : controllerUser.currentValue!.name,
                      onTap: () async {
                        await widget.userRepository.getAll();

                        return showItemsOptions(
                          context,
                          itemCount: widget.userRepository.controller.list.length,
                          label: 'Users',
                          itemBuilder: (_, index) => ItemView(
                            onTap: () {
                              controllerUser.setValueState(widget.userRepository.controller.list[index]);
                              Navigator.of(context).pop();
                            },
                            title: widget.userRepository.controller.list[index].name!,
                            subTitle: widget.userRepository.controller.list[index].email!,
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0, bottom: 20.0),
                    child: Text(
                      'Priority',
                      style:
                          GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
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
                      style:
                          GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
                    ),
                  ),
                  CustomCheckbox(
                    label: 'Carry out external cleaning of the electric',
                    value: StateController(currentValue: false),
                    onTap: (bool newValue) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 21.0, bottom: 34.0),
                    child: InkWell(
                      onTap: () {},
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
                    ),
                  ),
                  Material(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                    color: const Color(0xFF2188FF),
                    child: InkWell(
                      onTap: () {},
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
                              style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 16.0, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          ),
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
}
