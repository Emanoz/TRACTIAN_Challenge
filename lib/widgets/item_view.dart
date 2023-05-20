import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/enums/assets_status.dart';

class ItemView extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final AssetsStatus status;

  const ItemView(this.title, this.status, this.image, this.subTitle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: SvgPicture.asset(image),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.roboto(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF24292F),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        subTitle,
                        style: GoogleFonts.roboto(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8C959F),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 14.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Color(status.color()),
                      ),
                      child: Text(
                        status.text(),
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500, fontSize: 12.0, color: const Color(0xFFFAFAFA)),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SvgPicture.asset('resources/icons/rightArrow.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
