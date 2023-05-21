import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IconTitleTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const IconTitleTile({Key? key, required this.icon, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(icon),
            ),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: const Color(0xFF24292F),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 14.0),
              child: Text(
                subtitle,
                style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 14.0, color: const Color(0xFF57606A)),
              ),
            ),
          ],
        ),
        const Divider()
      ],
    );
  }
}
