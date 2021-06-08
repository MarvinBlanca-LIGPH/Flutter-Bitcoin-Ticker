import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/network/API.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var currency = currenciesList.first;
  var convertedBTC = '?';
  var convertedETH = '?';
  var convertedLTC = '?';

  @override
  void initState() {
    super.initState();
    getCurrencyConversion();
  }

  void getCurrencyConversion() async {
    var resultList = await API().getConversions(currency);
    for (var result in resultList) {
      String crypto = result['asset_id_base'];
      double rate = result['rate'];
      print(rate);
      updateUI(crypto, rate.round().toString(), currency);
    }
  }

  void updateUI(String crypto, String response, String currency) {
    setState(() {
      switch (crypto) {
        case 'BTC':
          convertedBTC = response;
          break;
        case 'ETH':
          convertedETH = response;
          break;
        case 'LTC':
          convertedLTC = response;
          break;
      }
      this.currency = currency;
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropDownItem.add(item);
    }

    return DropdownButton<String>(
      value: currenciesList.first,
      items: dropDownItem,
      onChanged: (value) {
        setState(() {
          currency = value;
          getCurrencyConversion();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItem = [];

    for (String currency in currenciesList) {
      pickerItem.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) {
        currency = currenciesList[selectedIndex];
        getCurrencyConversion();
      },
      itemExtent: 32.0,
      children: pickerItem,
    );
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
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ${cryptoList[0]} = $convertedBTC $currency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ${cryptoList[1]} = $convertedETH $currency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ${cryptoList[2]} = $convertedLTC $currency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
