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

  List<MetalRateModel> listOfNotes = [];

  static List<MetalRateModel> selectAllRecords() {
    // if(searchFor == '')
    //   {
    return myBox.values.toList();
    //   }else{
    //   return myBox.values.where((note) => note.noteTitle.toLowerCase().contains(searchFor)).toList();
    // }
  }

  static Future<MetalRateModel> selectOne(String categoryShotCut) async {
    MetalRateModel record;
    try {
      record = myBox.values.lastWhere((item) => item.metal == categoryShotCut);

      print('Selected record ---------------- ${record.recordID.toString()}');

      return record;
    }catch(ex)
    {
      print('Error while selected last record ${ex.toString()}');

      record = MetalRateModel(recordID: 0, timestamp: 0, metal: categoryShotCut, currency: 'EGP', openTime: 0, price: 0, ch: 0, ask: 0, bid: 0, priceGram24K: 0, priceGram22K: 0, priceGram21K: 0, priceGram20K: 0, priceGram18K: 0, priceGram16K: 0, priceGram14K: 0, priceGram10K: 0);
      return record;
    }
  }

  static Future<void> addRecord(MetalRateModel record) async {
    record.recordID = SharedMethods.getCurrentTimesTamp();
    await myBox.add(record);
  }

  static Future<void> deleteNote(MetalRateModel record) async {
    // Getting record index by noteID
    final index = myBox.values.toList().indexWhere((item) => item.recordID == record.recordID);
    //print('Selected recordID = ${record.recordID} and the index to delete $index');
    await myBox.deleteAt(index);
  }

  // static Future<void> saveRecord(MetalRateModel record) async {
  //     // Update record by record index
  //     final index = myBox.values.toList().indexWhere((item) => item.timestamp == record.timestamp);
  //     await myBox.putAt(index, record);
  // }


}