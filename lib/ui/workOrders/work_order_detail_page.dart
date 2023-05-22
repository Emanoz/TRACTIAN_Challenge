import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_app/ui/workOrders/work_order_form_page.dart';
import 'package:tractian_app/utils/state_controller.dart';

import '../../widgets/custom_checkbox.dart';
import '../../widgets/custom_radio.dart';

class WorkOrderDetailPage extends StatefulWidget {
  //final WorkOrder order;

  const WorkOrderDetailPage({Key? key}) : super(key: key);

  @override
  State<WorkOrderDetailPage> createState() => _WorkOrderDetailPageState();
}

class _WorkOrderDetailPageState extends State<WorkOrderDetailPage> {
  final checkBoxGroup = StateController(currentValue: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset('resources/icons/workOrderTitleIcon.svg'),
                Text(
                  'Compressor 3000h Analysis',
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
                ),
                CustomRadio(
                  currentIndex: 1,
                  checkBoxGroup: checkBoxGroup,
                  icon: Icons.refresh_outlined,
                  label: 'In Progress',
                  color: const Color(0xFF2188FF),
                ),
                CustomRadio(
                  currentIndex: 2,
                  checkBoxGroup: checkBoxGroup,
                  icon: Icons.check_circle_outline,
                  label: 'Done',
                  color: const Color(0xFF2188FF),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 26.0, bottom: 28.0),
              child: Row(
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
                        Row(
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
                                    'J',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Assigned',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400, fontSize: 16.0, color: const Color(0xFF24292F)),
                            ),
                          ],
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
                            color: Colors.red,
                          ),
                          child: Text(
                            'High',
                            style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.white),
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
                  style:
                      GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
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
                  'Asset',
                  style:
                      GoogleFonts.roboto(fontSize: 16.0, fontWeight: FontWeight.w400, color: const Color(0xFF24292F)),
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
                    'Compressor Preventive Maintenance (3000h)',
                    style:
                        GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 16.0, color: const Color(0xFF24292F)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Procedures checklist',
                style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 16.0, color: const Color(0xFF24292F)),
              ),
            ),
            const CustomCheckbox(
              label: 'Record temperature and pressure readings (air, oil, water)',
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2188FF),
        centerTitle: true,
        title: Text(
          //'#${order.id}',
          '#38',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WorkOrderFormPage())),
          child: const Icon(Icons.edit)),
    );
  }
}
