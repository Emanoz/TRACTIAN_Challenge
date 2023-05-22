import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_app/utils/enums/assets_status.dart';
import 'package:tractian_app/utils/state_controller.dart';
import 'package:tractian_app/widgets/custom_checkbox.dart';
import 'package:tractian_app/widgets/custom_radio.dart';
import 'package:tractian_app/widgets/item_view.dart';
import '../../widgets/custom_options_button.dart';

class WorkOrderFormPage extends StatefulWidget {
  const WorkOrderFormPage({Key? key}) : super(key: key);

  @override
  State<WorkOrderFormPage> createState() => _WorkOrderFormPageState();
}

class _WorkOrderFormPageState extends State<WorkOrderFormPage> {
  final checkBoxGroup = StateController(currentValue: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
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
                label: 'Select an Asset',
                onTap: () => showItemsOptions(
                  context,
                  label: 'Assets',
                  itemBuilder: (_, index) => const ItemView(
                    title: 'M14 Mill Shaft Motor',
                    status: AssetsStatus.inProgress,
                    image: 'resources/icons/exampleImage.svg',
                    subTitle: 'Injection/Painting',
                    hasIcon: false,
                  ),
                ),
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
                label: 'Select an User',
                onTap: () => showItemsOptions(
                  context,
                  label: 'Users',
                  itemBuilder: (_, index) => const ItemView(
                    title: 'John Doe',
                    subTitle: 'emanuel@hotmail.com',
                  ),
                ),
              ),
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
                    checkBoxGroup: checkBoxGroup,
                    currentIndex: 0,
                    label: 'Low',
                    color: const Color(0xFF2DA44E),
                  ),
                  CustomRadio(
                    checkBoxGroup: checkBoxGroup,
                    currentIndex: 1,
                    label: 'Medium',
                    color: const Color(0xFFE16F24),
                  ),
                  CustomRadio(
                    checkBoxGroup: checkBoxGroup,
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
              const CustomCheckbox(label: 'Carry out external cleaning of the electric'),
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
                  itemCount: 10,
                  separatorBuilder: (_, index) => const Divider(),
                  itemBuilder: (context, index) => itemBuilder(context, index),
                ),
              ),
            ],
          ),
        ),
      );
}
