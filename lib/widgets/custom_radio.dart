import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/state_controller.dart';

class CustomRadio extends StatelessWidget {
  final int currentIndex;
  final StateController checkBoxGroup;
  final IconData? icon;
  final String label;
  final Color color;

  const CustomRadio({
    required this.checkBoxGroup,
    required this.currentIndex,
    required this.label,
    required this.color,
    Key? key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Material(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: isSelected() ? color : Colors.white,
            child: InkWell(
              onTap: () => checkBoxGroup.setValueState(currentIndex),
              child: Container(
                width: 88.0,
                padding: EdgeInsets.symmetric(vertical: icon != null ? 16.0 : 0.0, horizontal: 12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: color)),
                child: Column(
                  children: [
                    if (icon != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(
                          icon,
                          color: isSelected() ? Colors.white : color,
                        ),
                      ),
                    Padding(
                      padding: icon != null ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        label,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: isSelected() ? Colors.white : color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        );
      }
    );
  }

  bool isSelected() => currentIndex == checkBoxGroup.currentValue;
}
