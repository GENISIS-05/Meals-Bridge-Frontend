import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cached_network_image/cached_network_image.dart';


class HomeScreenDistributor extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  const HomeScreenDistributor({Key? key, required this.screenHeight, required this.screenWidth}) : super(key: key);

  @override
  State<HomeScreenDistributor> createState() => _HomeScreenDistributor();
}

class _HomeScreenDistributor extends State<HomeScreenDistributor> {
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 5),
      );
      setState(() {
        _currentPosition = position!;
      });
    } catch (e) {
      print("Error: $e");
      // Handle the case when location cannot be obtained
      setState(() {
        // _currentPosition = Position(latitude: 0.0, longitude: 0.0);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: widget.screenHeight * 0.025542784,),
          Container(
            padding: EdgeInsets.all(widget.screenWidth * 0.038167939),
            alignment: Alignment.topLeft,
            child: CachedNetworkImage(
              imageUrl: 'Image',
              placeholder: (context, url) => CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.lightGreen,
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.lightGreen,
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.topLeft,
            child: Text(
              'Current Location: ${_currentPosition?.latitude ?? 0.0}, ${_currentPosition?.longitude ?? 0.0}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),

          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                MyCardView(title: "XYZ", imageUrl: "https://www.google.com/search?q=silicon+website&tbm=isch&chips=q:silicon+website,online_chips:silicon+institute:IwEpddL_wYo%3D&prmd=invsmbtz&rlz=1C1CHBD_enIN990IN990&hl=en&sa=X&ved=2ahUKEwi50qGwj7WEAxVGS2wGHVqZD7kQ4lYoAHoECAEQNA&biw=1519&bih=730#imgrc=ZrbnLf4UVCMqrM", distance: 4.5, quantity: 7.9,),
                MyCardView(title: "XYZ", imageUrl: "https://www.google.com/search?q=silicon+website&tbm=isch&chips=q:silicon+website,online_chips:silicon+institute:IwEpddL_wYo%3D&prmd=invsmbtz&rlz=1C1CHBD_enIN990IN990&hl=en&sa=X&ved=2ahUKEwi50qGwj7WEAxVGS2wGHVqZD7kQ4lYoAHoECAEQNA&biw=1519&bih=730#imgrc=ZrbnLf4UVCMqrM", distance: 4.5, quantity: 7.9,),
                MyCardView(title: "XYZ", imageUrl: "https://www.google.com/search?q=silicon+website&tbm=isch&chips=q:silicon+website,online_chips:silicon+institute:IwEpddL_wYo%3D&prmd=invsmbtz&rlz=1C1CHBD_enIN990IN990&hl=en&sa=X&ved=2ahUKEwi50qGwj7WEAxVGS2wGHVqZD7kQ4lYoAHoECAEQNA&biw=1519&bih=730#imgrc=ZrbnLf4UVCMqrM", distance: 4.5, quantity: 7.9,),
                MyCardView(title: "XYZ", imageUrl: "https://www.google.com/search?q=silicon+website&tbm=isch&chips=q:silicon+website,online_chips:silicon+institute:IwEpddL_wYo%3D&prmd=invsmbtz&rlz=1C1CHBD_enIN990IN990&hl=en&sa=X&ved=2ahUKEwi50qGwj7WEAxVGS2wGHVqZD7kQ4lYoAHoECAEQNA&biw=1519&bih=730#imgrc=ZrbnLf4UVCMqrM", distance: 4.5, quantity: 7.9,),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        child: BottomNavigationBar(
          backgroundColor: Colors.lightGreenAccent,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}


class MyCardView extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double distance;
  final double quantity;

  MyCardView({
    required this.title,
    required this.imageUrl,
    required this.distance,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {

    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.all(20.0),
      elevation: 5,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: wi * 0.127226463,
                  height: he * 0.06385696,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: wi * 0.045801527),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: he * 0.022988506,
                      ),
                    ),
                    Text(
                      'Distance: $distance km',
                      style: TextStyle(fontSize: he * 0.019157088),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: he * 0.019157088),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantity: $quantity kg',
                  style: TextStyle(fontSize: 16.0),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Details button click
                  },
                  child: Text('Details', style: TextStyle(color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent
                  ),
                ),
              ],
            ),
          ],
        ),
        // Add more widgets or customize as needed
      ),
    );
  }
}