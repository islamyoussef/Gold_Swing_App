import 'package:all_in_one/models/metal_shared_methods.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../ihelper/dio_helper.dart';
import '../ihelper/hive_helper.dart';
import '../ihelper/shared_methods.dart';
import '../models/metal_rate_model.dart';
import '../views/cust_widgets/cust_drawer.dart';
import 'package:flutter/material.dart';

import '../ihelper/shared_variables.dart';
import 'cust_widgets/cust_appbar.dart';
import 'cust_widgets/cust_general_reponse.dart';
import 'cust_widgets/cust_metal_category.dart';
import 'cust_widgets/cust_price_shape.dart';

class FrmMetalRate extends StatefulWidget {
  const FrmMetalRate({super.key});

  @override
  State<FrmMetalRate> createState() => _FrmMetalRateState();
}

class _FrmMetalRateState extends State<FrmMetalRate> {

  final DioHelper _dioHelper = DioHelper();

  String selectedMetalShortcut = '';
  String selectedCategoryImage = 'assets/images/Thinking.gif';
  late MetalRateModel metalRateModel;

  Future<void> selectMetalCategoryWithLastRecord() async {
    switch (selectedMetalShortcut) {
      case 'XAU':
        selectedCategoryImage = 'assets/images/gold.gif';
        break;
      case 'XAG':
        selectedCategoryImage = 'assets/images/silver.gif';
        break;
      case 'XPT':
        selectedCategoryImage = 'assets/images/platinum.gif';
        break;
      case 'XPD':
        selectedCategoryImage = 'assets/images/palladium.gif';
        break;
    }

    metalRateModel = await HiveHelper.selectOne(selectedMetalShortcut);

    if (metalRateModel.recordID == 0) {
      SharedMethods.msgOperationResult(
        context,
        'There is no records for this category',
        Colors.orangeAccent,
      );
    }
  }

  // For testing
  int timestamp =1743423942 ,openTime = 1743379200;
  double price = 1000,ch = 0,ask = 0,bid = 0,priceGram24K = 24,priceGram22K = 22,priceGram21K = 21,priceGram20K = 20,priceGram18K = 18,priceGram16K = 16,priceGram14K = 14,priceGram10K =10;
  void testing()
  {
    timestamp += 10000;
    openTime + 10000;

    price = 500;
    ch += 10;
    ask += 15;
    bid += 20;
    priceGram24K += 1000;
    priceGram22K += 1000;
    priceGram21K += 1000;
    priceGram20K += 1000;
    priceGram18K += 1000;
    priceGram16K += 1000;
    priceGram14K += 1000;
    priceGram10K += 1000;

    MetalRateModel newData = MetalRateModel(timestamp: timestamp, metal: selectedMetalShortcut, openTime: openTime, price: price, ch: ch, ask: ask, bid: bid, priceGram24K: priceGram24K, priceGram22K: priceGram22K, priceGram21K: priceGram21K, priceGram20K: priceGram20K, priceGram18K: priceGram18K, priceGram16K: priceGram16K, priceGram14K: priceGram14K, priceGram10K: priceGram10K);
    setState(() {
      metalRateModel = newData;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    metalRateModel = MetalRateModel(
      recordID: 0,
      timestamp: 0,
      metal: selectedMetalShortcut,
      currency: 'EGP',
      openTime: 0,
      price: 0,
      ch: 0,
      ask: 0,
      bid: 0,
      priceGram24K: 0,
      priceGram22K: 0,
      priceGram21K: 0,
      priceGram20K: 0,
      priceGram18K: 0,
      priceGram16K: 0,
      priceGram14K: 0,
      priceGram10K: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Gold Swing',
        onTapSync: () async {

          try
          {
            // Check connectivity
            var internetStatus = await Connectivity().checkConnectivity();
            if(internetStatus.contains(ConnectivityResult.wifi) || internetStatus.contains(ConnectivityResult.mobile))
            {
              if (selectedMetalShortcut == '') {
                SharedMethods.msgOperationResult(
                  context,
                  'You have to select a category first.',
                  Colors.orangeAccent,
                );
              } else {
                // Get current metal rate
                MetalRateModel newData =  await _dioHelper.selectRecord(selectedMetalShortcut);

                setState(() {
                  metalRateModel = newData;
                });
              }
            }
            else{
              SharedMethods.msgOperationResult(
                context,
                'There is no internet available now.',
                Colors.black26,
              );
            }
          }catch(ex)
          {
            SharedMethods.msgOperationResult(
              context,
              'Error while getting data \n ${metalRateModel.statusMsg} \n ${ex.toString()}',
              Colors.black26,
            );
          }
        },
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Horizontal carousel [listView]
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            margin: EdgeInsets.only(left: 8, right: 8, top: 10),
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: MetalSharedMethods.listOfMetals.length,
              itemBuilder: (context, index) {
                return CustomMetalCategory(
                  // Get metal category name & shortcut & category image
                  category: MetalSharedMethods.listOfMetals[index]['category'].toString(),
                  image: MetalSharedMethods.listOfMetals[index]['image'].toString(),
                  shortCut: MetalSharedMethods.listOfMetals[index]['shortCut'].toString(),
                  selectedCategory: selectedMetalShortcut,

                  onTap: () {
                    setState(() {
                      selectedMetalShortcut =
                          MetalSharedMethods.listOfMetals[index]['shortCut'].toString();
                      selectMetalCategoryWithLastRecord();
                    });
                  },
                );
              },
            ),
          ),

          // Image container
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            margin: EdgeInsets.only(left: 8, right: 8, top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 6,
                  blurRadius: 16,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Gif image
                Image.asset(selectedCategoryImage, height: 175, width: 175),

                // Open date
                Center(
                    child: Text(SharedMethods.convertTimesTampToDateTime(metalRateModel.openTime),style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: myGoldenColor
                    ),),
                ),

                Container(
                  margin: EdgeInsets.only(left: 26, right: 26, bottom: 16,top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomGeneralResponse(
                        title: 'Ounce Price: ',
                        value: metalRateModel.price,
                      ),

                      CustomGeneralResponse(
                        title: 'Change: ',
                        value: metalRateModel.ch,
                        compare: true,
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 26, right: 26, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomGeneralResponse(
                        title: 'Ask Price: ',
                        value: metalRateModel.ask,
                      ),

                      CustomGeneralResponse(
                        title: 'Bid Price: ',
                        value: metalRateModel.bid,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ListView
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              margin: EdgeInsets.only(left: 8, right: 8),
              color: Colors.white,
              child: ListView(
                physics:
                const BouncingScrollPhysics(), // Smooth scrolling effect
                children: [
                  CustomPriceShape(
                    weight: 'Gram 10K',
                    price: metalRateModel.priceGram10K.toStringAsFixed(2),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 14K',
                    price: metalRateModel.priceGram14K.toStringAsFixed(2),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 16K',
                    price: metalRateModel.priceGram16K.toStringAsFixed(2),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 18K',
                    price: metalRateModel.priceGram18K.toStringAsFixed(2),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 20K',
                    price: metalRateModel.priceGram20K.toStringAsFixed(2),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 21K',
                    price: metalRateModel.priceGram21K.toStringAsFixed(2),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 22K',
                    price: metalRateModel.priceGram22K.toStringAsFixed(2),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 24K',
                    price: metalRateModel.priceGram24K.toStringAsFixed(2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Drawer
      drawer: CustomDrawer(),

      // Save to hive db
      floatingActionButton:
      FloatingActionButton(
        tooltip: 'Save to archive',
        backgroundColor: myGoldenColor,
        child: const Icon(Icons.save_alt_sharp, color: myMainColor),
        onPressed: () {
          //testing();
          if (!(metalRateModel.price > 0)) {
            SharedMethods.msgOperationResult(
              context,
              'You have to get the ounce price first, it\'s now not > 0',
              Colors.red,
            );
          }else if(selectedMetalShortcut == ''){
            SharedMethods.msgOperationResult(
              context,
              'Please select metal Category first.',
              myGoldenColor,
            );
          } else {
            HiveHelper.addRecord(metalRateModel);
            String counter = HiveHelper.selectCount();

            SharedMethods.msgOperationResult(
              context,
              'Record saved successfully, you\'r archive has $counter records.',
              Colors.green,
            );
          }
        },),
    );
  }
}
