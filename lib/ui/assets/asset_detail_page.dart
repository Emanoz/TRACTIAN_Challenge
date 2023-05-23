import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_app/ui/assets/repository/asset_repository.dart';
import 'package:tractian_app/utils/enums/assets_status.dart';
import 'package:tractian_app/utils/state_controller.dart';
import 'package:tractian_app/widgets/icon_title_tile.dart';

import '../../data/models/asset_model.dart';
import '../../utils/repository_interface.dart';

class AssetDetailPage extends StatefulWidget {
  final Asset asset;
  final Repository<Asset> repository;

  const AssetDetailPage({Key? key, required this.asset, required this.repository}) : super(key: key);
  @override
  State<AssetDetailPage> createState() => _AssetDetailPageState();
}

class _AssetDetailPageState extends State<AssetDetailPage> {
  final controllerOpenOrders = StateController(currentValue: "");

  @override
  void initState() {
    initRequest();
    super.initState();
  }

  void initRequest() async {
    controllerOpenOrders.setValueState(await (widget.repository as AssetRepository).countOpenOrders(widget.asset.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: widget.asset.image != null
                    ? Image.network(widget.asset.image!, fit: BoxFit.fill)
                    : SvgPicture.asset('resources/icons/exampleImage.svg'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0, top: 20.0),
                child: Text(
                  widget.asset.name ?? '',
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
                      color: Color(widget.asset.checkStatus().color()),
                    ),
                    child: Text(
                      widget.asset.checkStatus().text(),
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500, fontSize: 14.0, color: const Color(0xFFFAFAFA)),
                    ),
                  ),
                ],
              ),
              const Divider(),
              IconTitleTile(
                icon: 'resources/icons/sensorIcon.svg',
                title: 'Sensor',
                subtitle: widget.asset.sensors?.first,
              ),
              IconTitleTile(
                icon: 'resources/icons/modelIcon.svg',
                title: 'Model',
                subtitle: widget.asset.model ?? '',
              ),
              /*Row(
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
              const Divider(),*/
              Observer(
                builder: (context) {
                  return IconTitleTile(icon: 'resources/icons/orderIcon.svg', title: 'Open Orders', subtitle: controllerOpenOrders.currentValue);
                }
              ),
              IconTitleTile(
                  icon: 'resources/icons/scoreIcon.svg',
                  title: 'Health Score',
                  subtitle: widget.asset.healthScore.toString()),
            ],
          ),
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
