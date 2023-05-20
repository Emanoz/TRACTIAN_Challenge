import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCheckbox extends StatelessWidget {
  final String label;

  const CustomCheckbox({Key? key, required this.label,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24.0,
          width: 24.0,
          padding: const EdgeInsets.only(right: 8.0),
          child: Checkbox(
            value: false,
            onChanged: (value) {},
          ),
        ),
        Expanded(
          child: Text(
            label,
            style:
            GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 14.0, color: const Color(0xFF24292F)),
          ),
        )
      ],
    );
  }
}
