import 'package:admin/Widgets/AppBar/CustomAppBar.dart';
import 'package:admin/Widgets/Chart/ColumnChart.dart';
import 'package:admin/Widgets/Chart/PieChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            const CustomAppBar(),
            _mainContent(context),
          ],
        ),
      ),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DashBoard",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _info(context, "Total Sales", r"$ 19,234,",
                    "lib/assets/Icons/dollar (1).png"),
                _info(context, "Total Orders", "3290",
                    "lib/assets/Icons/shopping-cart.png"),
                _info(context, "Total Products", "329",
                    "lib/assets/Icons/basket.png")
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _charts(),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Theme.of(context).colorScheme.onSecondary,
              height: MediaQuery.of(context).size.height - 700,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return _orderContainer(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _orderContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width / 2,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.onSecondary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '123',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text("Devson Lane"),
          Text("Devon@example.com"),
          Text(r"$ 778.35"),
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.4),
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text("Delivered"),
            ),
          ),
          Text("7/05/2020")
        ],
      ),
    );
  }

  Widget _info(
      BuildContext context, String title, String subtitle, String imagePath) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width / 5,
      margin: const EdgeInsets.only(right: 100),
      padding: const EdgeInsets.only(left: 20),
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.onSecondary),
      child: Center(
        child: ListTile(
          leading: Image.asset(imagePath),
          title: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _charts() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [ColumnChart(), Piechart()],
    );
  }
}
