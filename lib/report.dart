import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/transaction_data.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransData>(
        builder: (context , value , child) => Scaffold(
          body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300],
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade500,
                              offset:const Offset(4.0, 4.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                          const BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4.0, -4.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                        ]),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("B A L A N C E",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.5)
                              ),
                            ),
                            Text("\$${context.read<TransData>().totalBalance().toString()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Colors.black.withOpacity(0.5)
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      value: context.read<TransData>().totalIncome(),
                                      color: Colors.green,
                                      showTitle: false,
                                    ),
                                    PieChartSectionData(
                                      value: context.read<TransData>().totalExpense(),
                                      color: Colors.red,
                                      showTitle: false,
                                    )
                                  ],
                                ),
                                swapAnimationDuration:const Duration(milliseconds: 750),
                                swapAnimationCurve: Curves.easeInOutQuint,

                              ),
                            )
                          ],
                        ),
                    ),
                  ) ,
                ),
          ),
        );
  }
}


