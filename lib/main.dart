
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_tracker/data/transaction_data.dart';
import 'package:wallet_tracker/my_app.dart';

void main()  {

  runApp(
    ChangeNotifierProvider(
        create: (context) => TransData(),
        child: const  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyApp(),
        ),
    )
  );
}
