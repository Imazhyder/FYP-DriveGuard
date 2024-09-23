import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {
  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool _isExpanded = false;

  void _toggleContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: _toggleContainer,
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        firstChild: Container(
          width: screenWidth - 20,
          height: 100,
          color: Colors.blue,
          alignment: Alignment.center,
          child: ListTile(
            leading: Container(
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'lib/assets/images/product_1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text('Product Title'),
            subtitle: Text('Product Subtitle'),
          ),
        ),
        secondChild: Container(
          width: screenWidth - 20,
          height: 300,
          color: Colors.blue[50],
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'lib/assets/images/product_1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text('Product Title'),
                subtitle: Text('Product Subtitle'),
              ),
              SizedBox(height: 8.0),
              Text('Details about the product will be shown here.'),
              Text('Additional info goes here.'),
              Text('You can add more widgets here as needed.'),
            ],
          ),
        ),
        crossFadeState:
            _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
  }
}
