import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_app/utils/state_controller.dart';

class CustomCheckbox extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final StateController value;
  final Function(bool newValue) onTap;

  const CustomCheckbox({Key? key, this.controller, required this.label, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Row(
        children: [
          Container(
            height: 24.0,
            width: 24.0,
            padding: const EdgeInsets.only(right: 8.0),
            child: Checkbox(
              value: value.currentValue,
              onChanged: (newValue) {
                onTap(newValue!);
                value.setValueState(newValue);
              },
            ),
          ),
          Expanded(
            child: controller != null
                ? TextField(
                    controller: controller,
                  )
                : Text(
                    label,
                    style:
                        GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 14.0, color: const Color(0xFF24292F)),
                  ),
          )
        ],
      );
    });
  }
}
