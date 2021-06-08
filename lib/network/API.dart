import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/constants.dart';
import 'package:bitcoin_ticker/network/networking.dart';

class API {
  Future<List> getConversions(String currency) async {
    NetworkHelper networkHelper;
    var result = [];
    for (String crypto in cryptoList) {
      networkHelper = NetworkHelper(url: '$kCoinsURL/$crypto/$currency');
      var response = await networkHelper.getData();
      result.add(response);
    }
    return result;
  }
}
