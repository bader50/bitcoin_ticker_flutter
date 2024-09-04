import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/network_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int usdRate = 0;
  int selectedIndex = 0;
  NetworkHandler networkHandler = NetworkHandler();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      networkHandler.getAllData(selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (String crypto in cryptoList)
                RateWidget(
                    crypto: crypto,
                    networkHandler: networkHandler,
                    selectedIndex: selectedIndex),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (selectedIndex) {
                  setState(() {
                    this.selectedIndex = selectedIndex;
                    networkHandler.getAllData(selectedIndex);
                  });
                },
                children: [
                  for (String currency in currenciesList) Text(currency)
                ]),
          ),
        ],
      ),
    );
  }
}

class RateWidget extends StatelessWidget {
  const RateWidget({
    super.key,
    required this.crypto,
    required this.networkHandler,
    required this.selectedIndex,
  });

  final NetworkHandler networkHandler;
  final int selectedIndex;
  final String crypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = ${networkHandler.getRate(crypto)} ${currenciesList[selectedIndex]}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
