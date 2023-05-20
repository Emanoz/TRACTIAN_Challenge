import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_app/ui/workOrders/work_orders_page.dart';
import 'package:tractian_app/utils/state_controller.dart';

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    const WorkOrdersPage(),
    Container(color: Colors.amber),
    Container(color: Colors.black),
  ];
  final pageState = StateController(currentValue: 0);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: SvgPicture.asset('resources/images/tractianLogo.svg'),
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
      }
    );
  }
}
