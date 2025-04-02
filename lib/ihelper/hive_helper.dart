import 'package:all_in_one/ihelper/shared_methods.dart';
import 'package:all_in_one/models/metal_rate_model.dart';
import 'package:hive/hive.dart';

class HiveHelper{

  static const String metalBoxName = 'HiveBox_Metal';
  static late Box<MetalRateModel> myBox;

  static Future<void> init() async{
    // This function to open the box
    myBox = await Hive.openBox<MetalRateModel>(metalBoxName);
  }

  static List<MetalRateModel> selectAllRecords({String? metalCategoryShortcut =''}) {
    if(metalCategoryShortcut == '' || metalCategoryShortcut == null){
      return myBox.values.toList().reversed.toList();
    }else{
     return myBox.values.where((metal) => metal.metal.toLowerCase() == metalCategoryShortcut!.toLowerCase()).toList().reversed.toList();
    }
  }

  static Future<MetalRateModel> selectOne(String categoryShotCut) async {
    MetalRateModel record;
    try {
      record = myBox.values.lastWhere((item) => item.metal == categoryShotCut);
      return record;
    }catch(ex)
    {
      record = MetalRateModel(recordID: 0, timestamp: 0, metal: categoryShotCut, currency: 'EGP', openTime: 0, price: 0, ch: 0, ask: 0, bid: 0, priceGram24K: 0, priceGram22K: 0, priceGram21K: 0, priceGram20K: 0, priceGram18K: 0, priceGram16K: 0, priceGram14K: 0, priceGram10K: 0);
      return record;
    }
  }

  static String selectCount()  {
    String response='';
    try {
      response = myBox.values.length.toString();
      return response.toString();
    }catch(ex)
    {
      response = 'Error while counting all save records in local db. ${ex.toString()}';
      //record = MetalRateModel(recordID: 0, timestamp: 0, metal: categoryShotCut, currency: 'EGP', openTime: 0, price: 0, ch: 0, ask: 0, bid: 0, priceGram24K: 0, priceGram22K: 0, priceGram21K: 0, priceGram20K: 0, priceGram18K: 0, priceGram16K: 0, priceGram14K: 0, priceGram10K: 0);
      return response;
    }
  }


  static Future<void> addRecord(MetalRateModel record) async {
    record.recordID = SharedMethods.getCurrentTimesTamp();
    await myBox.add(record);
  }

  static Future<void> deleteRecord(MetalRateModel record) async {
    final index = myBox.values.toList().indexWhere((item) => item.recordID == record.recordID);
    await myBox.deleteAt(index);
  }

  // static Future<void> saveRecord(MetalRateModel record) async {
  //     // Update record by record index
  //     final index = myBox.values.toList().indexWhere((item) => item.timestamp == record.timestamp);
  //     await myBox.putAt(index, record);
  // }


}