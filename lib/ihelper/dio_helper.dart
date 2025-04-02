import 'package:all_in_one/ihelper/api_endpoints.dart';
import 'package:all_in_one/models/metal_rate_model.dart';
import 'package:dio/dio.dart';

class DioHelper{

  final Dio _dio = Dio();
  late MetalRateModel metalRateModel;

  Future<MetalRateModel> selectRecord(String categoryShortcut) async{
    //[https://www.goldapi.io/api/XAU/EGP]
    try{
      // Configure Dio
      _dio.options.headers = {
        'x-access-token': apiKeyMetal,
        'Content-Type': 'application/json',
      };

      Response response = await _dio.get('$apiEndPointMetal$categoryShortcut/EGP');
      //print('Response --------- ${response.data.toString()}');
      // response.statusCode
      if(response.data != null)
      {
        metalRateModel = MetalRateModel.fromJson(response.data);
        metalRateModel.statusMsg = 'ok';
      }
      //print('dio_helper Success --------- ${metalRateModel.priceGram21K.toString()}');
      return metalRateModel;
    }catch(ex){
      metalRateModel = MetalRateModel(statusMsg: 'Error happened while fetching data ${ex.toString()}', timestamp: 0, metal: categoryShortcut, openTime: 0, price: 0, ch: 0, ask: 0, bid: 0, priceGram24K: 0, priceGram22K: 0, priceGram21K: 0, priceGram20K: 0, priceGram18K: 0, priceGram16K: 0, priceGram14K: 0, priceGram10K: 0);
     // print('dio_helper Error --------- ${ex.toString()}');
      return metalRateModel;
    }
  }

}