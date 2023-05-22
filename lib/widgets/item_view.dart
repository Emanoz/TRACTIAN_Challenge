import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/enums/assets_status.dart';

class ItemView extends StatelessWidget {
  final String? image;
  final String title;
  final String subTitle;
  final AssetsStatus? status;
  final bool hasIcon;
  final VoidCallback? onTap;

  const ItemView({
    Key? key,
    required this.title,
    this.status,
    this.image,
    required this.subTitle,
    this.hasIcon = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: image == null
                  ? SvgPicture.asset('resources/icons/exampleImage.svg')
                  : SizedBox(
                      height: 72.0,
                      width: 72.0,
                      child: Image.network(
                        image!,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) {
                            return child;
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                        frameBuilder: (context, child, event, _) => child,
                      ),
                    ),
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
                    child: hasIcon
                        ? Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: SvgPicture.asset('resources/icons/locationIcon.svg'),
                              ),
                              Text(
                                subTitle,
                                style: GoogleFonts.roboto(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF8C959F),
                                ),
                              ),
                            ],
                          )
                        : Text(
                            subTitle,
                            style: GoogleFonts.roboto(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF8C959F),
                            ),
                          ),
                  ),
                  if (status != null)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 14.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Color(status!.color()),
                      ),
                      child: Text(
                        status!.text(),
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
    );
  }
}
