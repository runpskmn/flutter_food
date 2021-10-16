import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_food/pages/food/food_item.dart';
import 'package:flutter_food/pages/food/food_list_page.dart';
import 'package:flutter_food/pages/food/food_order_page.dart';
import 'package:http/http.dart' as http;

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  var _subPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _test,
        child: Icon(Icons.add, color: Colors.white,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Menu"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Your Order"
          )
        ],
        currentIndex: _subPageIndex,
        onTap: (index) {
          setState(() {
            _subPageIndex = index;
          });
        },
      ),
      body: _buildSubPage() ,
    );
  }

  Widget _buildSubPage(){
    switch(_subPageIndex) {
      case 0: // home page
        return FoodListPage();
      case 1:
        return OrderPage();
      default:
        return SizedBox.shrink();

    }
  }

  Future<void> _test() async{
      var url = Uri.parse('https://cpsu-test-api.herokuapp.com/foods');
      var response = await http.get(url);
      if(response.statusCode == 200){
        Map<String, dynamic> jsonBody  = json.decode(response.body);
        String status = jsonBody['status'];
        String? message = jsonBody['message'];
        List<dynamic> data = jsonBody['data'];
        
        var foodList = data.map((element) => FoodItem(id: element['id'],
            name: element['name'],
            price: element['price'],
            image: element['image'])).toList();
      }
  }

}
