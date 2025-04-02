import 'dart:developer';

import 'package:all_in_one/ihelper/hive_helper.dart';
import 'package:all_in_one/ihelper/shared_methods.dart';
import 'package:all_in_one/models/metal_rate_model.dart';
import 'package:all_in_one/views/cust_widgets/cust_drawer.dart';
import 'package:flutter/material.dart';
import '../ihelper/shared_variables.dart';
import 'cust_widgets/cust_appbar.dart';
import 'cust_widgets/cust_price_shape_archive.dart';
class FrmMetalArchiveBackUp extends StatefulWidget {
  const FrmMetalArchiveBackUp({super.key});

  @override
  State<FrmMetalArchiveBackUp> createState() => _FrmMetalRateState();
}

class _FrmMetalRateState extends State<FrmMetalArchiveBackUp> {

  String _ddlCategory = 'ALL';
  List<MetalRateModel> archiveList = [];

  // Get all save records in Hive box
  Future<List<MetalRateModel>> selectAll() async{
    archiveList.clear();
    archiveList = HiveHelper.selectAllRecords();

    return archiveList;
  }

  void resetCurrentValues(){
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectAll();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Gold Swing Archive', viewActionButton: false,),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: DropdownButton<String>(
                  value: _ddlCategory,
                  icon: Icon(Icons.menu),
                  style: TextStyle(color: myGoldenColor),
                  underline: Container(
                    height: 1,
                    color: myGoldenColor,
                  ),
                  items: [
                    DropdownMenuItem<String>(
                      value: 'ALL',
                      child: Text('All', style: kTextStyle(myGoldenColor),),
                    ),
                    DropdownMenuItem<String>(
                      value: 'XAU',
                      child: Text('Gold', style: kTextStyle(myGoldenColor),),
                    ),
                    DropdownMenuItem<String>(
                      value: 'XAG',
                      child: Text('Silver', style: kTextStyle(myGoldenColor),),
                    ),
                    DropdownMenuItem<String>(
                      value: 'XPT',
                      child: Text('Platinum', style: kTextStyle(myGoldenColor),),
                    ),
                    DropdownMenuItem<String>(
                      value: 'XPD',
                      child: Text('Palladium', style: kTextStyle(myGoldenColor),),
                    ),
                  ],
                  onChanged: (String? newValue){
                    setState(() {
                      _ddlCategory = newValue!;
                      print(_ddlCategory);
                    });
                  }
              ),
            ),

          ),
          // ListView
          Expanded(
            child: ListView.builder(
              itemCount: archiveList.length,
              itemBuilder: (context, index) {
                return CustomPriceShapeArchive(metalRateModel: archiveList[index], onTap: (){

                  openModalBottomSheet(archiveList[index]);

                },);
              },
            ),
          ),
        ],
      ),

      // Drawer
      drawer: CustomDrawer(),
    );
  }

  Future<void> openModalBottomSheet(MetalRateModel selectedRecord) async {
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
                  Text(currentMetalType(selectedRecord.metal.toLowerCase()),style: TextStyle(
                      color: myGoldenColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                  ),),

                  currentChangePriceSection(selectedRecord.ch),
                ],
              ),

              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ask Price: ${selectedRecord.ask}',style: kTextStyle(Colors.white70),),
                  Text('Bid Price: ${selectedRecord.bid}',style: kTextStyle(Colors.white70),),
                ],
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('10k ${selectedRecord.priceGram10K}',style: kTextStyle(Colors.white70),),
                  Text('14k ${selectedRecord.priceGram14K}',style: kTextStyle(Colors.white70),),
                ],
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('16k ${selectedRecord.priceGram16K}',style: kTextStyle(Colors.white70),),
                  Text('18k ${selectedRecord.priceGram18K}',style: kTextStyle(Colors.white70),),
                ],
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('20k ${selectedRecord.priceGram20K}',style: kTextStyle(Colors.white70),),
                  Text('21k ${selectedRecord.priceGram21K}',style: kTextStyle(Colors.white70),),
                ],
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('22k ${selectedRecord.priceGram22K}',style: kTextStyle(Colors.white70),),
                  Text('24k ${selectedRecord.priceGram24K}',style: kTextStyle(Colors.white70),),
                ],
              ),

              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: () {
                  // Delete current record
                  HiveHelper.deleteRecord(selectedRecord);
                  SharedMethods.msgOperationResult(context, 'This record was deleted successfully.', Colors.green);
                  selectAll();
                  setState(() {

                  });
                  // Close Modal
                  //Navigator.of(context).pop();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Delete', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        );

      },
    );
  }

  String currentMetalType(String metalShortCut) {
    switch (metalShortCut) {
      case 'xag':
        return 'Silver';
      case 'xpd':
        return 'Palladium';
      case 'xpt':
        return 'Platinum';
      default:
        return 'Gold';
    }
  }

  Widget currentChangePriceSection(double ch){
    return Row(
      children: [
        Text(ch.toString(), style: kTextStyle(Colors.white70),),

        SizedBox(width: 8,),

        Icon(
          ch > 0 ? Icons.arrow_upward : Icons.arrow_downward,
          weight: 20,
          color: ch > 0 ? Colors.green : Colors.red,
        )
      ],
    );
  }

  TextStyle kTextStyle(Color color) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

}


/*

[
    MetalRateModel(timestamp: 1743304714, metal: 'XAU', currency: 'EGP', openTime: 1743120000, price: 3084.84, ch: 28.22, ask: 3085.3, bid: 3084.25, priceGram24K: 99.1799, priceGram22K: 90.9149, priceGram21K: 86.7824, priceGram20K: 82.6499, priceGram18K: 74.3849, priceGram16K: 66.1199, priceGram14K: 57.8549, priceGram10K: 41.325),
    MetalRateModel(timestamp: 1743304714, metal: 'XAU', currency: 'EGP', openTime: 1743120000, price: 3084.84, ch: -28.22, ask: 3085.3, bid: 3084.25, priceGram24K: 99.1799, priceGram22K: 90.9149, priceGram21K: 86.7824, priceGram20K: 82.6499, priceGram18K: 74.3849, priceGram16K: 66.1199, priceGram14K: 57.8549, priceGram10K: 41.325),
    MetalRateModel(timestamp: 1743304714, metal: 'XPT', currency: 'EGP', openTime: 1743120000, price: 3084.84, ch: 28.22, ask: 3085.3, bid: 3084.25, priceGram24K: 99.1799, priceGram22K: 90.9149, priceGram21K: 86.7824, priceGram20K: 82.6499, priceGram18K: 74.3849, priceGram16K: 66.1199, priceGram14K: 57.8549, priceGram10K: 41.325),
    MetalRateModel(timestamp: 1743304714, metal: 'XAU', currency: 'EGP', openTime: 1743120000, price: 3084.84, ch: -28.22, ask: 3085.3, bid: 3084.25, priceGram24K: 99.1799, priceGram22K: 90.9149, priceGram21K: 86.7824, priceGram20K: 82.6499, priceGram18K: 74.3849, priceGram16K: 66.1199, priceGram14K: 57.8549, priceGram10K: 41.325),
    MetalRateModel(timestamp: 1743304714, metal: 'XAU', currency: 'EGP', openTime: 1743120000, price: 3084.84, ch: 28.22, ask: 3085.3, bid: 3084.25, priceGram24K: 99.1799, priceGram22K: 90.9149, priceGram21K: 86.7824, priceGram20K: 82.6499, priceGram18K: 74.3849, priceGram16K: 66.1199, priceGram14K: 57.8549, priceGram10K: 41.325),
    MetalRateModel(timestamp: 1743304714, metal: 'XAG', currency: 'EGP', openTime: 1743120000, price: 3084.84, ch: 28.22, ask: 3085.3, bid: 3084.25, priceGram24K: 99.1799, priceGram22K: 90.9149, priceGram21K: 86.7824, priceGram20K: 82.6499, priceGram18K: 74.3849, priceGram16K: 66.1199, priceGram14K: 57.8549, priceGram10K: 41.325),
    MetalRateModel(timestamp: 1743304714, metal: 'XAU', currency: 'EGP', openTime: 1743120000, price: 3084.84, ch: 28.22, ask: 3085.3, bid: 3084.25, priceGram24K: 99.1799, priceGram22K: 90.9149, priceGram21K: 86.7824, priceGram20K: 82.6499, priceGram18K: 74.3849, priceGram16K: 66.1199, priceGram14K: 57.8549, priceGram10K: 41.325),
    MetalRateModel(timestamp: 1743304714, metal: 'XAU', currency: 'EGP', openTime: 1743120000, price: 3084.84, ch: -28.22, ask: 3085.3, bid: 3084.25, priceGram24K: 99.1799, priceGram22K: 90.9149, priceGram21K: 86.7824, priceGram20K: 82.6499, priceGram18K: 74.3849, priceGram16K: 66.1199, priceGram14K: 57.8549, priceGram10K: 41.325),
    MetalRateModel(timestamp: 1743304714, metal: 'XAG', currency: 'EGP', openTime: 1743120000, price: 3084.84, ch: 28.22, ask: 3085.3, bid: 3084.25, priceGram24K: 99.1799, priceGram22K: 90.9149, priceGram21K: 86.7824, priceGram20K: 82.6499, priceGram18K: 74.3849, priceGram16K: 66.1199, priceGram14K: 57.8549, priceGram10K: 41.325),
    MetalRateModel(timestamp: 1743304714, metal: 'XAU', currency: 'EGP', openTime: 1743120000, price: 3084.84, ch: 28.22, ask: 3085.3, bid: 3084.25, priceGram24K: 99.1799, priceGram22K: 90.9149, priceGram21K: 86.7824, priceGram20K: 82.6499, priceGram18K: 74.3849, priceGram16K: 66.1199, priceGram14K: 57.8549, priceGram10K: 41.325),
    MetalRateModel(timestamp: 1743304714, metal: 'XAU', currency: 'EGP', openTime: 1743120000, price: 3084.84, ch: -28.22, ask: 3085.3, bid: 3084.25, priceGram24K: 99.1799, priceGram22K: 90.9149, priceGram21K: 86.7824, priceGram20K: 82.6499, priceGram18K: 74.3849, priceGram16K: 66.1199, priceGram14K: 57.8549, priceGram10K: 41.325),
  ];

* */