import 'dart:convert';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/conf.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  Map<String, String> dataRate = {
    for (String crypto in cryptoList) crypto: "?"
  };

  Future<void> getData(String selectedCrypto, int selectedFIAT) async {
    var uri = Uri.https(
        'rest.coinapi.io',
        'v1/exchangerate/$selectedCrypto/${currenciesList[selectedFIAT]}',
        {'apikey': API_KEY});

    var data = await http.get(uri);

    var jsonData = jsonDecode(data.body);

    print(jsonData);

    try {
      dataRate[selectedCrypto] = jsonData['rate'];
    } catch (e) {
      print(jsonData['error']);
    }
  }

  Future<Map<String, String>> getAllData(int selectedFIAT) async {
    for (String crypto in cryptoList) {
      await getData(crypto, selectedFIAT);
    }
    print(dataRate);
    return dataRate;
  }

  String getRate(String crypto) {
    String rate = '?';
    print(dataRate);
    if (dataRate[crypto] != null) rate = dataRate[crypto].toString();
    return rate;
  }
}
