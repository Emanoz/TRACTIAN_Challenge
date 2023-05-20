import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOptionsButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const CustomOptionsButton({Key? key, required this.onTap, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: const Color(0xFFD0D7DE)),
        ),
        child: Text(
          label,
          style: GoogleFonts.roboto(color: const Color(0xFFAFB8C1), fontWeight: FontWeight.w400, fontSize: 16.0),
        ),
      ),
    );
  }
}
