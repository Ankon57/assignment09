import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: firstPage(),
    );
  }
}

class firstPage extends StatefulWidget {
  @override
  _firstPageState createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  Map<String, int> itemCounts = {"Shirt": 1, "T-shirt": 1, "Pant": 1};
  double unitPrice = 35.0;

  void _incrementItem(String item) {
    setState(() {
      itemCounts[item] = itemCounts[item]! + 1;
    });
  }

  void _decrementItem(String item) {
    setState(() {
      itemCounts[item] = itemCounts[item]! > 0 ? itemCounts[item]! - 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount =
    itemCounts.values.fold(0, (previous, count) => previous + (count * unitPrice));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("My Bag", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildClothItem(
                    "Shirt",
                    "https://images.bewakoof.com/uploads/grid/app/types-of-shirts-for-men-bewakoof-blog-4-1610963788.jpg",
                    "Blue",
                  ),
                  _buildClothItem(
                    "T-shirt",
                    "https://img.freepik.com/premium-photo/guy-model-appearance-black-clothes-poses-gray-studio-background-male-fashion-portrait_257482-1465.jpg",
                    "Black",
                  ),
                  _buildClothItem(
                    "Pant",
                    "https://i.pinimg.com/736x/53/76/b0/5376b0dc53dcb9b4c4f07c630b756da4.jpg",
                    "White",
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(opacity: 0.6, child: Text("Total Amount")),
                Text("\$${totalAmount.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Congratulations on your checkout!")),
                );
              },
              child: Text("CHECK OUT"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(130),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildClothItem(String title, String imageUrl, String color) {
    Color clothColor;
    if (title == "Shirt") {
      clothColor = Colors.blue;
    } else if (title == "T-shirt") {
      clothColor = Colors.black;
    } else if (title == "Pant") {
      clothColor = Colors.white;
    } else {
      clothColor = Colors.red;
    }

    return Column(
      children: [
        Container(
          height: 120,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Opacity(opacity: 0.7, child: Text("Color:")),
                            SizedBox(width: 6),
                            Text(color),
                            SizedBox(width: 20),
                            Opacity(opacity: 0.7, child: Text("Size:")),
                            SizedBox(width: 6),
                            Text("L"),
                          ],
                        ),
                        Row(
                          children: [
                            _buildCircleIcon(Icons.remove, () => _decrementItem(title)),
                            SizedBox(width: 10),
                            Text("${itemCounts[title]}", style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 10),
                            _buildCircleIcon(Icons.add, () => _incrementItem(title)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Opacity(
                          opacity: 0.6,
                          child: Icon(
                            Icons.more_vert,
                            size: 32,
                          ),
                        ),
                        Text("\$${(unitPrice * itemCounts[title]!).toStringAsFixed(2)}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildCircleIcon(IconData iconData, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 12,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(child: Icon(iconData, color: Colors.black.withOpacity(0.75), size: 22)),
      ),
    );
  }
}