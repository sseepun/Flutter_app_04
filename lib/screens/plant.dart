import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/plant.dart';

class PlantScreen extends StatefulWidget {
  final Plant plant;
  final int plantIndex;

  PlantScreen({
    this.plant,
    this.plantIndex,
  });

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Stack(
                children: <Widget>[

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 490,
                    decoration: BoxDecoration(
                      color: Color(0xFF32A060),
                    ),
                  ),

                  Positioned(
                    right: ScreenUtil().setWidth(50),
                    bottom: 35,
                    child: Hero(
                      tag: 'plant-'+widget.plantIndex.toString(), 
                      child: Image(
                        image: AssetImage(widget.plant.imageUrl),
                        height: 275,
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(50),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(60),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.shopping_cart,
                                size: 30,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),
                        Text(
                          widget.plant.category.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          widget.plant.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 40,),
                        Text(
                          'FROM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          '\$${widget.plant.price}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 40,),
                        Text(
                          'SIZE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          widget.plant.size,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 40,),
                        RawMaterialButton(
                          padding: EdgeInsets.all(15),
                          shape: CircleBorder(),
                          elevation: 2,
                          fillColor: Colors.black,
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            print('Add to cart');
                          },
                        ),

                      ],
                    ),
                  ),
                  
                ],
              ),

              Container(
                transform: Matrix4.translationValues(0, -20, 0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(50),
                    vertical: ScreenUtil().setHeight(80),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'All to know...',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        widget.plant.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),

                      SizedBox(height: 20,),
                      Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        'Plant height: 35-45 cm',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                      Text(
                        'Nursery pot width: 12 cm',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
