import 'dart:developer';

import '../ihelper/dio_helper.dart';
import '../ihelper/hive_helper.dart';
import '../ihelper/shared_methods.dart';
import '../models/metal_rate_model.dart';
import '../views/cust_widgets/cust_drawer.dart';
import 'package:flutter/material.dart';

import '../ihelper/api_endpoints.dart';
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

  DioHelper _dioHelper = DioHelper();

  String selectedCategory = '';
  String selectedCategoryImage = 'assets/images/gold.gif';

  late MetalRateModel metalRateModel;
  final List<Map<String, String>> listOfMetals = [
    {
      'category': 'Gold XAU',
      'image': 'assets/images/Category_Gold.jpg',
      'shortCut': 'XAU',
    },
    {
      'category': 'Silver XAG',
      'image': 'assets/images/Category_Silver.jpg',
      'shortCut': 'XAG',
    },
    {
      'category': 'Platinum XPT',
      'image': 'assets/images/Category_Platinum.jpg',
      'shortCut': 'XPT',
    },
    {
      'category': 'Palladium XPD',
      'image': 'assets/images/Category_Palladium.jpg',
      'shortCut': 'XPD',
    },
  ];

  Future<void> selectMetalCategoryWithLastRecord() async {
    switch (selectedCategory) {
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

    metalRateModel = await HiveHelper.selectOne(selectedCategory);

    log(
      'Selected last record in category ${metalRateModel.metal} -- ${metalRateModel.recordID.toString()}',
    );

    if (metalRateModel.recordID == 0) {
      SharedMethods.msgOperationResult(
        context,
        'There is no records for this category',
        Colors.orangeAccent,
      );
    }
  }

  Future<void> fetchData() async {
    log('${apiEndPointMetal}XAU/EGP');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    metalRateModel = MetalRateModel(
      recordID: 0,
      timestamp: 0,
      metal: selectedCategory,
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Gold Swing',
        onTapSync: () async {
          if (selectedCategory == '') {
            SharedMethods.msgOperationResult(
              context,
              'You have to select a category first.',
              Colors.orangeAccent,
            );
          } else {

            MetalRateModel newData =  await _dioHelper.selectRecord(selectedCategory);

            setState(() {
              metalRateModel = newData;
            });
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
              itemCount: listOfMetals.length,
              itemBuilder: (context, index) {
                return CustomMetalCategory(
                  // Get metal category name & shortcut & category image
                  category: listOfMetals[index]['category'].toString(),
                  image: listOfMetals[index]['image'].toString(),
                  shortCut: listOfMetals[index]['shortCut'].toString(),
                  selectedCategory: selectedCategory,

                  onTap: () {
                    setState(() {
                      selectedCategory =
                          listOfMetals[index]['shortCut'].toString();
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
                Image.asset(selectedCategoryImage, height: 175, width: 175),

                Container(
                  margin: EdgeInsets.only(left: 26, right: 26, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomGeneralResponse(
                        title: 'Last Price: ',
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
                    price: metalRateModel.priceGram10K.toString(),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 14K',
                    price: metalRateModel.priceGram14K.toString(),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 16K',
                    price: metalRateModel.priceGram16K.toString(),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 18K',
                    price: metalRateModel.priceGram18K.toString(),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 20K',
                    price: metalRateModel.priceGram20K.toString(),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 21K',
                    price: metalRateModel.priceGram21K.toString(),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 22K',
                    price: metalRateModel.priceGram22K.toString(),
                  ),
                  CustomPriceShape(
                    weight: 'Gram 24K',
                    price: metalRateModel.priceGram24K.toString(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          metalRateModel.price += 1000;
          if (!(metalRateModel.price > 0)) {
            SharedMethods.msgOperationResult(
              context,
              'The last price is not > 0',
              Colors.red,
            );
          } else {
            /*
              metalRateModel = MetalRateModel(
                  timestamp: 0,
                  metal: selectedCategory,
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
                  priceGram10K: 0);
              metalRateModel.timestamp += 1000;
              metalRateModel.openTime += 1000;
              metalRateModel.price += 1000;
*/
            log('Metal ${metalRateModel.metal.toString()}');
            log('Price10 ${metalRateModel.priceGram10K.toString()}');
            log('TimesTamp ${metalRateModel.timestamp.toString()}');
            log('statusMsg ${metalRateModel.statusMsg.toString()}');

            HiveHelper.addRecord(metalRateModel);

            SharedMethods.msgOperationResult(
              context,
              'Record saved successfully.',
              Colors.green,
            );

            log(metalRateModel.toString());
          }
        },
        tooltip: 'Save to archive',
        backgroundColor: myGoldenColor,
        child: const Icon(Icons.save_alt_sharp, color: myMainColor),
      ),
    );
  }
}

/*
ListView.builder(
                physics: const BouncingScrollPhysics(), // Smooth scrolling effect
                itemCount: metalRates.length,
                itemBuilder: (context, index) {
                  return CustomPriceShape(
                    weight: metalRates[index]['weight']!,
                    price: metalRates[index]['price']!,
                  );
                },
              )
* */
