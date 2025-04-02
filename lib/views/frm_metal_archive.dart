import 'package:all_in_one/controllers/cubit/archive_cubit.dart';
import 'package:all_in_one/ihelper/shared_methods.dart';
import 'package:all_in_one/models/metal_rate_model.dart';
import 'package:all_in_one/models/metal_shared_methods.dart';
import 'package:all_in_one/views/cust_widgets/cust_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../ihelper/shared_variables.dart';
import 'cust_widgets/cust_appbar.dart';
import 'cust_widgets/cust_price_shape_archive.dart';

class FrmMetalArchive extends StatefulWidget {
  const FrmMetalArchive({super.key, this.metalCatShortcut = ''});

  final String metalCatShortcut;

  @override
  State<FrmMetalArchive> createState() => _FrmMetalRateState();
}

class _FrmMetalRateState extends State<FrmMetalArchive> {

  void refreshList(){
    context.read<ArchiveCubit>().getRecords(metalCategoryShortcut: widget.metalCatShortcut);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Gold Swing Archive',
        viewActionButton:false,
      ),

      body:
        BlocBuilder<ArchiveCubit, ArchiveState>(
          builder: (context, state) {
            if (state is ArchiveLoadingState) {
              return Center(child: CircularProgressIndicator(color: myGoldenColor,));
            }
            else if (state is ArchiveFailureState) {
              return Center(child: Text(state.errorMsg, style: kTextStyle(Colors.redAccent),));
            } else if (state is ArchiveSuccessState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // ListView
                  Expanded(
                    child: ListView.builder(
                      //itemCount: archiveList.length,
                      itemCount: state.listOfData.length,
                      itemBuilder: (context, index) {
                        return CustomPriceShapeArchive(
                          metalRateModel: state.listOfData[index],
                          onTap: () {
                            openModalBottomSheet(state.listOfData[index],(){
                              // Delete current record
                              context.read<ArchiveCubit>().deleteRecord(state.listOfData[index]);

                              int currentCounter  = state.listOfData.length - 1;

                              //HiveHelper.deleteRecord(state.listOfData[index]);
                              SharedMethods.msgOperationResult(
                                context,
                                'This record was deleted successfully, you\'r archive has $currentCounter records.',
                                Colors.green,
                              );

                              // Close Modal
                              //Navigator.of(context).pop();
                              Navigator.pop(context);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('Un-known State',style: kTextStyle(Colors.orangeAccent),));
            }
          },
        ),

      // Drawer
      drawer: CustomDrawer(),
    );
  }

  Future<void> openModalBottomSheet(MetalRateModel selectedRecord, VoidCallback onDeleteClick) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 16, bottom: 16, right: 26, left: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    MetalSharedMethods.selectedMetalTypeByShortcut(selectedRecord.metal),
                    style: TextStyle(
                      color: myGoldenColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  currentChangePriceSection(selectedRecord.ch),
                ],
              ),

              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kText('Ask Price: ${selectedRecord.ask.toStringAsFixed(2)}'),
                  kText('Bid Price: ${selectedRecord.bid.toStringAsFixed(2)}'),
                ],
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kText('10k ${selectedRecord.priceGram10K.toStringAsFixed(2)}'),
                  kText('14k ${selectedRecord.priceGram14K.toStringAsFixed(2)}'),
                ],
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kText('16k ${selectedRecord.priceGram16K.toStringAsFixed(2)}'),
                  kText('18k ${selectedRecord.priceGram18K.toStringAsFixed(2)}'),
                ],
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kText('20k ${selectedRecord.priceGram20K.toStringAsFixed(2)}'),
                  kText('21k ${selectedRecord.priceGram21K.toStringAsFixed(2)}'),
                ],
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kText('22k ${selectedRecord.priceGram22K.toStringAsFixed(2)}'),
                  kText('24k ${selectedRecord.priceGram24K.toStringAsFixed(2)}'),
                ],
              ),

              SizedBox(height: 15),
              ElevatedButton(
                onPressed: onDeleteClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget currentChangePriceSection(double ch) {
    return Row(
      children: [
        Text(ch.toStringAsFixed(2), style: kTextStyle(Colors.white70)),

        SizedBox(width: 8),

        Icon(
          ch > 0 ? Icons.arrow_upward : Icons.arrow_downward,
          weight: 20,
          color: ch > 0 ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  TextStyle kTextStyle(Color color) {
    return TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w600);
  }

  RichText kText(String text){
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w600),
        children: [
          TextSpan(text: text),
          TextSpan(
            text: ' EGP',
            style: TextStyle(color: myGoldenColor, fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

}
