import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_app/utils/enums/assets_status.dart';
import 'package:tractian_app/widgets/icon_title_tile.dart';

class AssetDetailPage extends StatelessWidget {
  const AssetDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset(
                'resources/icons/exampleImage.svg',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0, top: 20.0),
              child: Text(
                '8A Motor Pump',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: const Color(0xFF24292F),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset('resources/icons/kmIcon.svg'),
                ),
                Text(
                  'Status',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: const Color(0xFF24292F),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 14.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.0),
                    color: Color(AssetsStatus.inProgress.color()),
                  ),
                  child: Text(
                    AssetsStatus.inProgress.text(),
                    style:
                        GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 14.0, color: const Color(0xFFFAFAFA)),
                  ),
                ),
              ],
            ),
            const Divider(),
            const IconTitleTile(
              icon: 'resources/icons/sensorIcon.svg',
              title: 'Sensor',
              subtitle: 'GSJ1535',
            ),
            const IconTitleTile(
              icon: 'resources/icons/modelIcon.svg',
              title: 'Model',
              subtitle: 'Pumps',
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset('resources/icons/rollerIcon.svg'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Roller Bearings Data',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: const Color(0xFF24292F),
                        ),
                      ),
                    ),
                    Text(
                      '''Model: GYA010RRB (Dodge)\nBPFO: 407,07Hz   |   BPFI: 659,6Hz\nBSF: 265,87Hz   |   FTF: 50,93Hz''',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: const Color(0xFF57606A),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            const IconTitleTile(icon: 'resources/icons/orderIcon.svg', title: 'Open Orders', subtitle: '2'),
            const IconTitleTile(icon: 'resources/icons/scoreIcon.svg', title: 'Health Score', subtitle: '80'),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2188FF),
        centerTitle: true,
        title: Text(
          //'#${order.id}',
          '8A Motor Pump',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
