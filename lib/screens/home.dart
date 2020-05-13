import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/plant.dart';
import '../models/plant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  int _selectedPage = 0;

  Widget _plantCard(Plant plant, int plantIndex) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - plantIndex;
          value = (1 - (value.abs() * 0.3)).clamp(0, 1);
        }
        return Center(
          child: SizedBox(
            width: Curves.easeInOut.transform(value) * 400,
            height: Curves.easeInOut.transform(value) * 420,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (_) => PlantScreen(
                plant: plant, plantIndex: plantIndex
              ),
            )
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            Container(
              decoration: BoxDecoration(
                color: Color(0xFF32A060),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.fromLTRB(10, 10, 10, 26)
            ),

            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 30
                ),
                child: Hero(
                  tag: 'plant-'+plantIndex.toString(),
                  child: Image(
                    image: AssetImage(plant.imageUrl),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 30,
              right: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'FROM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    '\$${plant.price}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 65,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    plant.category.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 3,),
                  Text(
                    plant.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 0,
              child: RawMaterialButton(
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
                  return Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (_) => PlantScreen(
                        plant: plant, plantIndex: plantIndex
                      ),
                    )
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 5, vsync: this,);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8,);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: ListView(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(60),
          ),
          children: <Widget>[

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Colors.black,
                  ),
                ],
              ),
            ),

            SizedBox(height: 17,),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.withOpacity(0.6),
              labelPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(100),
              ),
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Top',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Outdoor',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Indoor',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'New Arrivals',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Limited Edition',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10,),
            Container(
              height: 420,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _selectedPage = index;
                  });
                },
                itemCount: plants.length,
                itemBuilder: (BuildContext context, int index) {
                  return _plantCard(plants[index], index);
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    plants[_selectedPage].description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
    );
  }
}
