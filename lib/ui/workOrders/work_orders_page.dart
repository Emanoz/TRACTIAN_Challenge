import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_app/ui/workOrders/work_order_form_page.dart';
import 'package:tractian_app/utils/enums/assets_status.dart';
import '../../widgets/item_view.dart';

class WorkOrdersPage extends StatelessWidget {
  const WorkOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 32.0,
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Search work order',
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFFD9D9D9),
                    ),
                    labelStyle:
                        GoogleFonts.roboto(color: const Color(0xFFAFB8C1), fontWeight: FontWeight.w400, fontSize: 16.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Color(0xFFD0D7DE)),
                      borderRadius: BorderRadius.circular(35.0),
                    )),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ListView.separated(
                  itemCount: 30,
                  itemBuilder: (_, item) => ItemView(
                    title: 'exemplo',
                    status: AssetsStatus.inProgress,
                    image: 'resources/icons/exampleImage.svg',
                    subTitle: 'exemploSub',
                    hasIcon: false,
                    onTap: () =>
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WorkOrderFormPage())),
                  ),
                  separatorBuilder: (_, index) => Container(
                    color: const Color(0xFFD0D7DE),
                    height: 2.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WorkOrderFormPage())),
          child: const Icon(Icons.add)),
    );
  }
}
