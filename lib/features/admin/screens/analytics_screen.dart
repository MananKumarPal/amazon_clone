import 'package:amazon_clone/features/admin/widgets/category_products_chart.dart'
    as charts;
import 'package:flutter/material.dart';

import '../../../common/widgets/loader.dart';
import '../models/sales.dart';
import '../services/admin_services.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Total sales\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: charts.CategoryProductsChart(sales: earnings!),
              ),
            ],
          );
  }
}
// SizedBox(
              //     height: 250,
              //     // child: ChartPage(futureEarnings: getEarnings())
              //     // (seriesList: [
              //     //     charts.Series(
              //     //       id: 'Sales',
              //     //       data: earnings!,
              //     //       domainFn: (Sales sales, _) => sales.label,
              //     //       measureFn: (Sales sales, _) => sales.earning,
              //     //     ),
              //     //   ]),
              //     )