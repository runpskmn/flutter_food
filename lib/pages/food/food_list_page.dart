import 'package:flutter/material.dart';
import 'package:flutter_food/pages/food/food_detail.dart';
import 'package:flutter_food/pages/food/food_item.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  var items = [
    FoodItem(
        id: 1,
        name: "ข้าวผัดอเมริกัน",
        price: 60,
        image: "american_fried_rice.jpg"
    ),
    FoodItem(
        id: 2,
        name: "สปาเกตตี้ขี้เมาทะเล",
        price: 55,
        image: "spaghetti_khee_mao.jpg"
    ),
    FoodItem(
        id: 3,
        name: "ข้าวไข่เจียว",
        price: 35,
        image: "kao_kai_jeaw.jpg"
    ),
    FoodItem(
        id: 4,
        name: "ข้าวหมูแดง",
        price: 40,
        image: "kao_moo_dang.jpg"
    ),
    FoodItem(
        id: 5,
        name: "ผัดไทย",
        price: 30,
        image: "pad_thai.jpg"
    ),
    FoodItem(
        id: 6,
        name: "ราดหน้า",
        price: 40,
        image: "rad_na.jpg"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0)
                ),
                margin: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(
                      context,
                      FoodDetail.routeName,
                      arguments: items[index],
                    );

                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3.0),
                            topRight: Radius.circular(3.0)
                        ),
                        child: Image.asset(
                          "assets/images/${items[index].image}",
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(items[index].name),
                            Text("${items[index].price} บาท")
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
