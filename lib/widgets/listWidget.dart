import 'package:flutter/material.dart';

/// ListWidget is to display the predefined city list.
class ListWidget extends StatelessWidget {
  final List<String> list;
  final Function(String cityName) onCLick;

  const ListWidget({Key? key, required this.list, required this.onCLick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              onCLick(list[index]);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.white)),
              child: Text(
                list[index],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
