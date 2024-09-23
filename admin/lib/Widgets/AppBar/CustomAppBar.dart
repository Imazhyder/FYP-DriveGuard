import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 100,
      width: MediaQuery.of(context).size.width / 1.5 + 400,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
      child: Row(
        children: [
          Expanded(
              flex: 7,
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer))),
              )),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.sunny)),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications)),
                const SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                    shape: const StadiumBorder(),
                    onPressed: () => {},
                    child: const Icon(Icons.person))
              ],
            ),
          )
        ],
      ),
    );
  }
}
