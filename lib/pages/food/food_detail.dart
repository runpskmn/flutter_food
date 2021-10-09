
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/pages/food/food_item.dart';

class FoodDetail extends StatefulWidget {
  static const routeName = '/foodDetail';

  const FoodDetail({Key? key}) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  int itemCount = 1;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FoodItem;
    return Scaffold(
      appBar: AppBar(
        title: Text("${args.name}", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white)
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/${args.image}"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ชื่อเมนู: ${args.name}"),
                    Text("ราคา: ${args.price} บาท"),
                  ],
                ),
              ),
              Expanded(child: SizedBox.shrink()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        if(itemCount > 1)
                          itemCount--;
                      });
                    },
                    child: Icon(Icons.remove, color: Colors.orange,),
                  ),
                  SizedBox(width: 14.0,),
                  Text("$itemCount", style: Theme.of(context).textTheme.bodyText2,),
                  SizedBox(width: 14.0,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        itemCount++;
                      });
                    },
                    child: Icon(Icons.add, color: Colors.orange,),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(onPressed: (){},
                        child: Text(
                            "เพิ่มลงตะกร้า",
                            style: TextStyle(fontSize: 16.0, color: Colors.white)
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
