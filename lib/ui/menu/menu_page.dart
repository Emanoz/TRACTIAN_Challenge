import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_app/ui/assets/assets_page.dart';
import 'package:tractian_app/ui/qrcode/qrcode_reader_page.dart';
import 'package:tractian_app/ui/workOrders/work_orders_page.dart';
import 'package:tractian_app/utils/state_controller.dart';

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    const WorkOrdersPage(),
    const AssetsPage(),
    const QrCodeReaderPage(),
  ];
  final pageState = StateController(currentValue: 0);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            pageState.currentValue == 0
                ? 'Work Orders'
                : pageState.currentValue == 1
                    ? 'Assets'
                    : 'Qr Code Reader',
            style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18.0),
          ),
          centerTitle: true,
        ),
        body: _pages[pageState.currentValue],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageState.currentValue,
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset('resources/icons/workOrdersIcon.svg'), label: 'Work Orders'),
            BottomNavigationBarItem(icon: SvgPicture.asset('resources/icons/assetsIcon.svg'), label: 'Assets'),
            BottomNavigationBarItem(icon: SvgPicture.asset('resources/icons/qrCodeIcon.svg'), label: 'QR Code'),
          ],
          onTap: (index) => pageState.setValueState(index),
        ),
      );
    });
  }
}
