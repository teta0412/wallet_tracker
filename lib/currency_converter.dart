import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyConverter {
  final String apiUrl = 'https://api.exchangerate-api.com/v4/latest/USD'; // Replace with your preferred API endpoint

  Future<Map<String, dynamic>> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  double convert(double amount, double exchangeRate) {
    return amount * exchangeRate;
  }
}
class CurrencyConverterApp extends StatefulWidget {
  @override
  _CurrencyConverterAppState createState() => _CurrencyConverterAppState();
}

class _CurrencyConverterAppState extends State<CurrencyConverterApp> {
  final CurrencyConverter _currencyConverter = CurrencyConverter();
  double _amount = 1.0;
  String _selectedCurrency = 'USD';

  Map<String, dynamic>? _exchangeRates;

  @override
  void initState() {
    super.initState();
    _fetchExchangeRates();
  }

  void _fetchExchangeRates() async {
    try {
      final data = await _currencyConverter.fetchExchangeRates();
      setState(() {
        _exchangeRates = data['rates'];
      });
    } catch (e) {
      print('Error fetching exchange rates: $e');
    }
  }

  void _convertCurrency() {
    if (_exchangeRates != null) {
      final exchangeRate = _exchangeRates![_selectedCurrency];
      if (exchangeRate != null) {
        setState(() {
          _amount = _currencyConverter.convert(_amount, exchangeRate);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Currency Converter'),
        // ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount in USD'),
                onChanged: (value) {
                  setState(() {
                    _amount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 20.0),
              DropdownButton<String>(
                value: _selectedCurrency,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCurrency = newValue!;
                  });
                },
                items: _exchangeRates?.keys.map((currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: _convertCurrency,
                child: Text('Convert'),
              ),
              SizedBox(height: 50.0),
              Text('Converted Amount: $_amount $_selectedCurrency'),
            ],
          ),
        ),
      ),
    );
  }
}